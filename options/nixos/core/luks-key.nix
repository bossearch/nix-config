{
  hosts,
  lib,
  pkgs,
  ...
}: let
  luks = lib.elem hosts.disko.type [
    "btrfs-luks-impermanence"
    "btrfs-luks"
  ];
in {
  config = lib.mkIf luks {
    boot.initrd.kernelModules = ["uas" "usbcore" "usb_storage" "vfat" "nls_cp437" "nls_iso8859_1"];
    boot.initrd.postDeviceCommands = pkgs.lib.mkBefore ''
      mkdir -m 0755 -p /key
      for i in $(seq 1 10); do
        if [ -e /dev/disk/by-uuid/DA30-0796 ]; then
          echo ">> Found USB device."
          mount -n -t vfat -o ro /dev/disk/by-uuid/DA30-0796 /key && break
        fi
        sleep 1
      done
      if [ ! -e /key/luks.key ]; then
        echo ">> Keyfile not found."
        if command -v plymouth >/dev/null 2>&1; then
          echo ">> Exiting Plymouth to show prompt..."
          plymouth --quit || true
        fi
      fi
    '';

    boot.initrd.luks.devices.nixos = {
      keyFile = "/key/luks.key";
      fallbackToPassword = true; # Allow password if USB key is missing
      preLVM = false;
    };
  };
}
