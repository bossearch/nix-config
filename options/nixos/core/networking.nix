{
  config,
  lib,
  ...
}: {
  config = lib.mkMerge [
    {
      networking = {
        hostName = config.spec.hostname;
        networkmanager.enable = true;
      };
    }
    {
      networking.firewall = {
        enable = config.spec.networking.firewall.enable;
        allowPing = false;
        rejectPackets = true;
        allowedTCPPorts = config.spec.networking.firewall.allTCPPorts;
        allowedUDPPorts = config.spec.networking.firewall.allUDPPorts;
        allowedTCPPortRanges = config.spec.networking.firewall.allTCPPortRanges;
        allowedUDPPortRanges = config.spec.networking.firewall.allUDPPortRanges;
        extraCommands = lib.concatStringsSep "\n" config.spec.networking.firewall.allExtraCmds;
        trustedInterfaces = lib.mkIf config.spec.virtmanager ["virbr0"];
      };
    }
    (lib.mkIf config.spec.dnscrypt {
      networking = {
        nameservers = ["127.0.0.1" "::1"];
        networkmanager.dns = "none";
      };
    })
    (lib.mkIf config.spec.bridge {
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
    })
  ];
}
