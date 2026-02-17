{
  config,
  lib,
  ...
}: let
  enableSwap = config.spec.disko.swap != "0G" && config.spec.disko.swap != "" && config.spec.disko.swap != null;
in {
  config = lib.mkIf (config.spec.disko.type == "ext4-luks") {
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
            plainSwap = lib.mkIf enableSwap {
              size = config.spec.disko.swap;
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "nixos";
                settings.keyFile = "/key/luks.key";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
