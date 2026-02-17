{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.spec.disko.type
    == "ext4") {
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

            root = {
              size = "100%";
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
}
