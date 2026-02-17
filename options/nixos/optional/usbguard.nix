{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.spec.usbguard {
    environment.systemPackages = with pkgs; [
      usbutils
      usbguard
    ];

    services.usbguard = {
      enable = true;
      dbus.enable = true;

      # Default policies
      presentDevicePolicy = "apply-policy"; # Allow existing devices
      presentControllerPolicy = "apply-policy"; # Allow existing hub
      insertedDevicePolicy = "apply-policy"; # New devices require approval

      rules = lib.mkMerge [
        (lib.mkIf (config.spec.hostname == "silvia") ''
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
          allow id 4653:0001 with-interface { 03:01:01 03:00:00 }
          allow id 1b1c:1b3e serial "0A026035AF359CA25B23342BF5001BC6" with-interface { 03:01:02 03:00:00 }
        '')
        (lib.mkIf (config.spec.hostname == "stagea") ''
          allow id 1d6b:0002 serial "0000:02:00.0" with-interface 09:00:00
          allow id 1d6b:0003 serial "0000:02:00.0" with-interface 09:00:00
          allow id 0627:0001 serial "28754-0000:00:02.1:00.0-1" with-interface 03:00:00
        '')
      ];
    };
  };
}
