{
  hosts,
  lib,
  pkgs,
  ...
}: let
  run = pkgs.writeShellScript "usbguard-launcher.sh" ''
    ESCAPED_PATH=$(${pkgs.systemd}/bin/systemd-escape "$1")
    ${pkgs.systemd}/bin/systemctl --machine=${hosts.username}@.host --user start "usbguard-prompt@$ESCAPED_PATH.service"
  '';
in {
  services.udev = {
    enable = true;
    packages =
      # [
      #   pkgs.android-udev-rules
      #   pkgs.libu2f-host
      # ]
      # ++ (
      lib.optionals hosts.udevqmk [pkgs.unstable.qmk-udev-rules]
      # )
      ;

    extraRules = lib.concatStringsSep "\n" (
      lib.flatten [
        (lib.optional (hosts.usbguard && hosts.hostname == "silvia") ''
          # usbguard rules
          ACTION=="add", SUBSYSTEM=="usb", ENV{DEVNAME}!="", \
          ENV{ID_VENDOR_ID}!="1b1c", ENV{ID_MODEL_ID}!="1b3e", \
          ENV{ID_VENDOR_ID}!="4653", ENV{ID_MODEL_ID}!="0001", \
          ENV{ID_VENDOR_ID}!="2109", ENV{ID_MODEL_ID}!="2815", \
          ENV{ID_VENDOR_ID}!="05e3", ENV{ID_MODEL_ID}!="0610", \
          RUN+="${run} $env{DEVNAME}"
        '')

        (lib.optional (hosts.usbguard && hosts.hostname == "stagea") ''
          ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{DEVNAME}!="", \
          RUN+="${run} $env{DEVNAME}"
        '')

        (lib.optional (hosts.udevqmk && hosts.hostname == "silvia") ''
          # raw-hid for corne
          SUBSYSTEM=="usb", ATTRS{idVendor}=="4653", ATTRS{idProduct}=="0001", MODE="0666", TAG+="uaccess"
          KERNEL=="hidraw*", ATTRS{idVendor}== "4653", ATTRS{idProduct}=="0001", MODE="0666", TAG+="uaccess"
        '')
      ]
    );
  };
}
