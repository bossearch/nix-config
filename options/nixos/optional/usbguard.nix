{
  hosts,
  lib,
  pkgs,
  ...
}: let
  automatedusbguard = pkgs.writeShellScript "automatedusbguard.sh" ''
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
    /run/wrappers/bin/pkexec ${pkgs.usbguard}/bin/usbguard allow-device "$BLOCKED_ID"
    fi
  '';
in {
  config = lib.mkIf hosts.usbguard {
    environment.systemPackages = with pkgs; [
      usbutils
      usbguard
    ];

    services.usbguard = {
      enable = true;
      dbus.enable = true;
      IPCAllowedUsers = ["root" "${hosts.username}"];

      presentDevicePolicy = "apply-policy"; # Allow existing devices
      presentControllerPolicy = "apply-policy"; # Allow existing hub
      insertedDevicePolicy = "apply-policy"; # New devices require approval

      rules = lib.mkMerge [
        (lib.mkIf (hosts.hostname == "silvia") ''
          allow id 1d6b:0002 serial "0000:08:00.3" with-interface 09:00:00
          allow id 1d6b:0003 serial "0000:08:00.3" with-interface 09:00:00
          allow id 1d6b:0002 serial "0000:08:00.4" with-interface 09:00:00
          allow id 1d6b:0003 serial "0000:08:00.4" with-interface 09:00:00
          allow id 1d6b:0002 serial "0000:09:00.0" with-interface 09:00:00

          allow id 1d6b:0003 serial "0000:09:00.0" with-interface 09:00:00
          allow id 0bda:5411 with-interface { 09:00:01 09:00:02 }
          allow id 0bda:0411 with-interface 09:00:00
          allow id 05e3:0610 with-interface { 09:00:01 09:00:02 }
          allow id 8087:0aa7 with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 }

          allow id 2109:2815 with-interface { 09:00:01 09:00:02 }
          allow id 4653:0001
          allow id 1b1c:1b3e serial "0A026035AF359CA25B23342BF5001BC6" with-interface { 03:01:02 03:00:00 }
        '')
        (lib.mkIf (hosts.hostname == "stagea") ''
          allow id 1d6b:0002 serial "0000:02:00.0" with-interface 09:00:00
          allow id 1d6b:0003 serial "0000:02:00.0" with-interface 09:00:00
          allow id 0627:0001 serial "28754-0000:00:02.1:00.0-1" with-interface 03:00:00
        '')
      ];
    };
    systemd.user.services."usbguard-prompt@" = {
      description = "USBGuard User Prompt for %i";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${automatedusbguard} %I";
        RemainAfterExit = false;
      };
    };
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
          if (action.id == "org.usbguard.Policy1.modify") {
              return polkit.Result.AUTH_ADMIN;
          }
      });
    '';
  };
}
