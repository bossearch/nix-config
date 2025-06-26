{
  config,
  lib,
  ...
}: {
  disko.devices = {
    disk.main = {
      type = "disk";
      device = config.spec.disk;
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
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["noatime" "compress=zstd" "subvol=@home"];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["noatime" "compress=zstd" "subvol=@nix"];
                  };
                  "@swap" = lib.mkIf config.spec.swap {
                    mountpoint = "/swap";
                    mountOptions = ["noatime" "subvol=@swap"];
                    swap.swapfile.size = config.spec.swapSize;
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
