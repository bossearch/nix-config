{inputs, ...}: {
  imports = [inputs.disko.nixosModules.disko];
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/vda";
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
            };
          };

          luks = {
            size = "100%";
            label = "luks";
            content = {
              type = "luks";
              name = "enc";
              passwordFile = "/key/luks";
              settings.keyFile = "/key/luks.key";
              content = {
                type = "btrfs";
                extraArgs = ["-L" "nixos" "-f"];
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
                  "@swap" = {
                    mountpoint = "/swap";
                    mountOptions = ["noatime" "subvol=@swap"];
                    swap.swapfile.size = "1G";
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
