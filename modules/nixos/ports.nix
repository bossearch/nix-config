{ lib, config, ... }:

let
  inherit (lib) mkOption types;

  p = config.port;

  declaredTCPPorts = p.TCPPorts or [];
  declaredUDPPorts = p.UDPPorts or [];
  declaredTCPPortRanges = p.TCPPortsRanges or [];
  declaredUDPPortRanges = p.UDPPortsRanges or [];
  declaredExtraCmds = lib.optional (p.extra != null && p.extra != "") p.extra;
in {
  options = {
    port = mkOption {
      type = types.submodule {
        options = {
          TCPPorts = mkOption {
            type = types.listOf types.port;
            default = [];
            description = "Allowed individual TCP ports.";
          };

          UDPPorts = mkOption {
            type = types.listOf types.port;
            default = [];
            description = "Allowed individual UDP ports.";
          };

          TCPPortsRanges = mkOption {
            type = types.listOf (types.submodule {
              options = {
                from = mkOption { type = types.port; };
                to = mkOption { type = types.port; };
              };
            });
            default = [];
            description = "TCP port ranges.";
          };

          UDPPortsRanges = mkOption {
            type = types.listOf (types.submodule {
              options = {
                from = mkOption { type = types.port; };
                to = mkOption { type = types.port; };
              };
            });
            default = [];
            description = "UDP port ranges.";
          };

          extra = mkOption {
            type = types.str;
            default = ''
              iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW \
              -m limit --limit 3/min --limit-burst 3 -j ACCEPT
            '';
            description = "Extra iptables commands.";
          };
        };
      };
      default = {};
      description = "Declarative firewall port and iptables entries.";
    };

    allTCPPorts = mkOption {
      type = types.listOf types.port;
      readOnly = true;
      default = declaredTCPPorts;
    };

    allUDPPorts = mkOption {
      type = types.listOf types.port;
      readOnly = true;
      default = declaredUDPPorts;
    };

    allTCPPortRanges = mkOption {
      type = types.listOf (types.attrsOf types.port);
      readOnly = true;
      default = declaredTCPPortRanges;
    };

    allUDPPortRanges = mkOption {
      type = types.listOf (types.attrsOf types.port);
      readOnly = true;
      default = declaredUDPPortRanges;
    };

    allExtraCmds = mkOption {
      type = types.listOf types.str;
      readOnly = true;
      default = declaredExtraCmds;
    };
  };
}
