{
  hosts,
  lib,
  ...
}: {
  config = lib.mkMerge [
    {
      networking = {
        hostName = hosts.hostname;
        networkmanager.enable = true;
      };
    }
    {
      networking.firewall = {
        enable = hosts.networking.firewall.enable;
        allowPing = false;
        rejectPackets = true;
        allowedTCPPorts = hosts.networking.firewall.allTCPPorts;
        allowedUDPPorts = hosts.networking.firewall.allUDPPorts;
        allowedTCPPortRanges = hosts.networking.firewall.allTCPPortRanges;
        allowedUDPPortRanges = hosts.networking.firewall.allUDPPortRanges;
        extraCommands = lib.concatStringsSep "\n" hosts.networking.firewall.allExtraCmds;
        trustedInterfaces = lib.mkIf hosts.virtmanager ["virbr0"];
      };
    }
    (lib.mkIf hosts.dnscrypt {
      networking = {
        nameservers = ["127.0.0.1" "::1"];
        networkmanager.dns = "none";
      };
    })
    (lib.mkIf hosts.bridge {
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
