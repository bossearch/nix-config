{
  hosts,
  lib,
  ...
}: let
  enableSwap = hosts.disko.swap != "0G" && hosts.disko.swap != "" && hosts.disko.swap != null;
in {
  config = lib.mkIf (hosts.disko.type == "btrfs-luks-impermanence") {
    disko.devices = {
      disk.main = {
        type = "disk";
        device = hosts.disk;
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

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "nixos";
                settings.keyFile = "/key/luks.key";
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
    };
    fileSystems."/persist".neededForBoot = true;
  };
}
