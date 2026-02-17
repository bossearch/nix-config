{
  hosts,
  lib,
  ...
}: let
  enableSwap = hosts.disko.swap != "0G" && hosts.disko.swap != "" && hosts.disko.swap != null;
in {
  config = lib.mkIf (hosts.disko.type == "ext4") {
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
            plainSwap = lib.mkIf enableSwap {
              size = hosts.disko.swap;
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
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
