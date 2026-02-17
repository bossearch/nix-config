{
  hosts,
  lib,
  ...
}: let
  enableSwap = hosts.disko.swap != "0G" && hosts.disko.swap != "" && hosts.disko.swap != null;
in {
  config = lib.mkIf (hosts.disko.type == "btrfs-impermanence") {
    disko.devices = {
      disk.main = {
        type = "disk";
        device = hosts.disko.disk;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };

            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = ["noatime" "compress=zstd" "subvol=@root"];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["noatime" "compress=zstd" "subvol=@persist"];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["noatime" "compress=zstd" "subvol=@nix"];
                  };
                  "@swap" = lib.mkIf enableSwap {
                    mountpoint = "/swap";
                    mountOptions = ["noatime" "subvol=@swap"];
                    swap.swapfile.size = hosts.disko.swap;
                  };
                };
              };
            };
          };
        };
      };
    };
    fileSystems."/persist".neededForBoot = true;
  };
}
