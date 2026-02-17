{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.spec.disko.type
    == "btrfs-impermanence") {
    disko.devices = {
      disk.main = {
        type = "disk";
        device = config.spec.disko.disk;
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
                  "@swap" = lib.mkIf config.spec.disko.swap {
                    mountpoint = "/swap";
                    mountOptions = ["noatime" "subvol=@swap"];
                    swap.swapfile.size = config.spec.disko.swapSize;
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
