{
  config,
  lib,
  pkgs,
  ...
}: {
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
      (lib.mkIf (config.spec.hostName == "pc") ''
        allow id 1d6b:0002 serial "0000:08:00.3" name "xHCI Host Controller" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0003 serial "0000:08:00.3" name "xHCI Host Controller" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0002 serial "0000:08:00.4" name "xHCI Host Controller" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0003 serial "0000:08:00.4" name "xHCI Host Controller" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0002 serial "0000:09:00.0" name "xHCI Host Controller" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0003 serial "0000:09:00.0" name "xHCI Host Controller" with-interface 09:00:00 with-connect-type ""
        allow id 0bda:5411 serial "" name "USB2.1 Hub" via-port "3-1" with-interface { 09:00:01 09:00:02 } with-connect-type "unknown"
        allow id 0bda:0411 serial "" name "USB3.2 Hub" via-port "4-1" with-interface 09:00:00 with-connect-type "unknown"
        allow id 05e3:0610 serial "" name "USB2.0 Hub" via-port "5-1" with-interface { 09:00:01 09:00:02 } with-connect-type "unknown"
        allow id 05e3:0610 serial "" name "USB2.1 Hub" via-port "3-1.2" with-interface { 09:00:01 09:00:02 } with-connect-type "hotplug"
        allow id 8087:0aa7 serial "" name "" via-port "5-1.3" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "hotplug"
        allow id 05e3:0610 serial "" name "USB2.0 Hub" via-port "5-1.4" with-interface { 09:00:01 09:00:02 } with-connect-type "unknown"
        allow id 2109:2815 serial "" name "USB2.0 Hub             " via-port "3-1.2.3" with-interface { 09:00:01 09:00:02 } with-connect-type "unknown"
        allow id 4653:0001 serial "" name "Corne" via-port "3-1.2.3.1" with-interface { 03:01:01 03:00:00 } with-connect-type "unknown"
        allow id 1b1c:1b3e serial "0A026035AF359CA25B23342BF5001BC6" name "Corsair Gaming SCIMITAR PRO RGB Mouse" with-interface { 03:01:02 03:00:00 } with-connect-type "unknown"
      '')
      (lib.mkIf (config.spec.hostName == "vm") ''
        allow id 1d6b:0002 serial "0000:02:00.0" name "xHCI Host Controller" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0003 serial "0000:02:00.0" name "xHCI Host Controller" with-interface 09:00:00 with-connect-type ""
        allow id 0627:0001 serial "28754-0000:00:02.1:00.0-1" name "QEMU USB Tablet" with-interface 03:00:00 with-connect-type "unknown"
      '')
    ];
  };
}
