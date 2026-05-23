{
  config,
  hosts,
  lib,
  pkgs,
  ...
}: let
  usbguard_script = pkgs.writeShellScript "usbguard-prompt" ''
    DEVICE_PATH="$1"
    LOCKFILE="/tmp/usbguard_lock_$(echo "$DEVICE_PATH" | tr '/' '_')"

    if [ -e "$LOCKFILE" ]; then exit 0; fi
    touch "$LOCKFILE"
    trap "rm -f $LOCKFILE" EXIT

    DEVICE_NAME=$(udevadm info --query=property --name="$DEVICE_PATH" | grep -i "ID_MODEL=" | cut -d= -f2 || echo "Unknown Device")
    DEVICE_VENDOR=$(udevadm info --query=property --name="$DEVICE_PATH" | grep -i "ID_VENDOR=" | cut -d= -f2 || echo "Unknown Vendor")

    BLOCKED_ID=$(${pkgs.usbguard}/bin/usbguard list-devices | grep block | grep -oP '^[0-9]+' | tail -1)

    if [ -z "$BLOCKED_ID" ]; then
      exit 0
    fi

    if ${pkgs.zenity}/bin/zenity --question \
      --title="USBGuard" \
      --text="<b>Vendor:</b> $DEVICE_VENDOR\n<b>Model:</b>  $DEVICE_NAME" \
      --width=200 \
      --ok-label="Allow" \
      --cancel-label="Block"; then
    /run/wrappers/bin/pkexec /run/current-system/sw/bin/usbguard allow-device "$BLOCKED_ID"
    fi
  '';
in {
  config = lib.mkIf hosts.usbguard {
    environment.systemPackages = with pkgs; [
      usbutils
      usbguard
    ];

    sops = lib.mkIf (hosts.hostname == "silvia") {
      secrets.usbguard = {
        owner = "root";
        group = "root";
        mode = "0400";
      };
    };

    services.usbguard = lib.mkMerge [
      {
        enable = true;
        dbus.enable = true;
        IPCAllowedUsers = ["root" "${hosts.username}"];
        insertedDevicePolicy = "apply-policy";
        presentControllerPolicy = "apply-policy";
        presentDevicePolicy = "apply-policy";
      }
      (lib.mkIf (hosts.hostname == "silvia") {
        ruleFile = config.sops.secrets.usbguard.path;
      })
      (lib.mkIf (hosts.hostname == "stagea") {
        rules = ''
          allow id 1d6b:0002 serial "0000:02:00.0" with-interface 09:00:00
          allow id 1d6b:0003 serial "0000:02:00.0" with-interface 09:00:00
          allow id 0627:0001 serial "28754-0000:00:02.1:00.0-1" with-interface 03:00:00
        '';
      })
    ];
    systemd.user.services."usbguard-prompt@" = lib.mkIf hosts.gui.enable {
      description = "USBGuard User Prompt for %i";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${usbguard_script} %I";
        RemainAfterExit = false;
      };
    };
    security.polkit.extraConfig = lib.mkIf hosts.gui.enable ''
      polkit.addRule(function(action, subject) {
          if (action.id == "org.usbguard.Policy1.modify") {
              return polkit.Result.AUTH_ADMIN;
          }
      });
    '';
  };
}
