{
  config,
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
  sops = lib.mkIf (hosts.gui.enable && hosts.usbguard && hosts.hostname == "silvia") {
    secrets.udev1 = {};
    secrets.udev2 = {};
    templates."udevRules" = {
      path = "/run/udev/rules.d/99-secrets.rules";
      owner = "root";
      group = "root";
      mode = "0400";
      content = ''
        ACTION=="add", SUBSYSTEM=="usb", ENV{DEVNAME}!="", GOTO="run_usbguard"
        GOTO="skip_usbguard"
        LABEL="run_usbguard"

        ${config.sops.placeholder.udev1}

        RUN+="${usbguard} $env{DEVNAME}"
        LABEL="skip_usbguard"

        ${config.sops.placeholder.udev2}
      '';
    };
  };

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
        (lib.optional (hosts.gui.enable && hosts.usbguard && hosts.hostname == "stagea") ''
          ACTION=="add", SUBSYSTEM=="usb", ENV{DEVNAME}!="", GOTO="run_usbguard"
          GOTO="skip_usbguard"
          LABEL="run_usbguard"
          RUN+="${usbguard} $env{DEVNAME}"
          LABEL="skip_usbguard"
        '')
      ]
    );
  };
}
