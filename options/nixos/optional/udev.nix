{
  hosts,
  lib,
  pkgs,
  ...
}: let
  usbguard = pkgs.writeShellScript "usbguard-service" ''
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
        (lib.optional (hosts.gui.enable && hosts.usbguard && hosts.hostname == "silvia") ''
          ACTION=="add", SUBSYSTEM=="usb", ENV{DEVNAME}!="", GOTO="run_usbguard"
          GOTO="skip_usbguard"
          LABEL="run_usbguard"

          # usbguard rules for mouse, keyboard, usbhub, and usbhub monitor
          ENV{ID_VENDOR_ID}=="1b1c", ENV{ID_MODEL_ID}=="1b3e", GOTO="skip_usbguard"
          ENV{ID_VENDOR_ID}=="4653", ENV{ID_MODEL_ID}=="0001", GOTO="skip_usbguard"
          ENV{ID_VENDOR_ID}=="2109", ENV{ID_MODEL_ID}=="2815", GOTO="skip_usbguard"
          ENV{ID_VENDOR_ID}=="05e3", ENV{ID_MODEL_ID}=="0610", GOTO="skip_usbguard"

          RUN+="${usbguard} $env{DEVNAME}"
          LABEL="skip_usbguard"
        '')

        (lib.optional (hosts.gui.enable && hosts.usbguard && hosts.hostname == "stagea") ''
          ACTION=="add", SUBSYSTEM=="usb", ENV{DEVNAME}!="", GOTO="run_usbguard"
          GOTO="skip_usbguard"
          LABEL="run_usbguard"
          RUN+="${usbguard} $env{DEVNAME}"
          LABEL="skip_usbguard"
        '')

        (lib.optional (hosts.gui.enable && hosts.udevqmk && hosts.hostname == "silvia") ''
          # raw-hid for corne
          SUBSYSTEM=="usb", ATTRS{idVendor}=="4653", ATTRS{idProduct}=="0001", MODE="0666", TAG+="uaccess"
          KERNEL=="hidraw*", ATTRS{idVendor}== "4653", ATTRS{idProduct}=="0001", MODE="0666", TAG+="uaccess"
        '')
      ]
    );
  };
}
