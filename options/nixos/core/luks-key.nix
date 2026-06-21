{
  hosts,
  lib,
  ...
}: let
  luks = lib.elem hosts.disko.type [
    "btrfs-luks-impermanence"
    "btrfs-luks"
  ];
  timeout = 15;
in {
  config = lib.mkIf luks {
    boot.initrd = {
      kernelModules = ["uas" "usbcore" "usb_storage" "vfat" "nls_cp437" "nls_iso8859_1"];
      systemd = {
        enable = true;
        mounts = [
          {
            what = "/dev/disk/by-uuid/DA30-0796";
            where = "/key";
            type = "vfat";
            options = "ro";
          }
        ];
        settings.Manager = {
          DefaultDeviceTimeoutSec = "${toString timeout}s";
        };
      };
      luks.devices.nixos = {
        keyFile = "/key/luks.key";
        keyFileTimeout = timeout;
      };
    };
  };
}
