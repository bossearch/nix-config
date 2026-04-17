{
  hosts,
  lib,
  pkgs,
  ...
}: let
  service = pkgs.writeShellScript "usbguard-service" ''
    DEVICE_PATH="$1"
    ESCAPED_PATH=$(${pkgs.systemd}/bin/systemd-escape "$DEVICE_PATH")
    USER_ID=$(id -u ${hosts.username})

    runuser -u ${hosts.username} -- env \
      XDG_RUNTIME_DIR=/run/user/$USER_ID \
      DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus \
      DISPLAY=:0 \
      ${pkgs.systemd}/bin/systemctl --user start "usbguard-prompt@$ESCAPED_PATH.service"
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
      lib.optionals hosts.udevqmk [pkgs.qmk-udev-rules]
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
          RUN+="${service} $env{DEVNAME}"
        '')

        (lib.optional (hosts.usbguard && hosts.hostname == "stagea") ''
          ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{DEVNAME}!="", \
          RUN+="${service} $env{DEVNAME}"
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
