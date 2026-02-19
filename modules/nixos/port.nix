{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  p = config.hosts.networking.firewall.port;
in {
  options.hosts.networking.firewall = {
    port = mkOption {
      type = types.submodule {
        options = {
          TCPPorts = mkOption {
            type = types.listOf types.port;
            default = [];
          };
          UDPPorts = mkOption {
            type = types.listOf types.port;
            default = [];
          };
          TCPPortsRanges = mkOption {
            type = types.listOf (types.submodule {
              options = {
                from = mkOption {type = types.port;};
                to = mkOption {type = types.port;};
              };
            });
            default = [];
          };
          UDPPortsRanges = mkOption {
            type = types.listOf (types.submodule {
              options = {
                from = mkOption {type = types.port;};
                to = mkOption {type = types.port;};
              };
            });
            default = [];
          };
          extra = mkOption {
            type = types.str;
            default = ''
              iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW \
              -m limit --limit 3/min --limit-burst 3 -j ACCEPT
            '';
          };
        };
      };
      default = {};
    };

    # These are "derived" options. They collect the data for easy use elsewhere.
    allTCPPorts = mkOption {
      type = types.listOf types.port;
      readOnly = true;
      default = p.TCPPorts;
    };

    allUDPPorts = mkOption {
      type = types.listOf types.port;
      readOnly = true;
      default = p.UDPPorts;
    };

    allTCPPortRanges = mkOption {
      type = types.listOf (types.attrsOf types.port);
      readOnly = true;
      default = p.TCPPortsRanges;
    };

    allUDPPortRanges = mkOption {
      type = types.listOf (types.attrsOf types.port);
      readOnly = true;
      default = p.UDPPortsRanges;
    };

    allExtraCmds = mkOption {
      type = types.listOf types.str;
      readOnly = true;
      default = lib.optional (p.extra != null && p.extra != "") p.extra;
    };
  };
}
