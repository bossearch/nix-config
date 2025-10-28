{
  networking.networkmanager.ensureProfiles.profiles = {
    "br0" = {
      connection = {
        id = "br0";
        type = "bridge";
        interface-name = "br0";
        autoconnect = false;
      };
      ipv4.method = "auto";
      ipv6.method = "ignore";
    };

    "br0-port" = {
      connection = {
        id = "br0-port";
        type = "ethernet";
        # Change if your NIC is named differently
        # interface-name = "enp5s0";
        autoconnect = false;
        master = "br0";
        slave-type = "bridge";
      };
      match-device.type = "ethernet";
    };
  };
}
