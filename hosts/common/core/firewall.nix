{
  config,
  lib,
  ...
}: {
  networking.firewall = {
    enable = true;
    allowPing = false;
    rejectPackets = true;

    allowedTCPPorts = config.allTCPPorts;
    allowedTCPPortRanges = config.allTCPPortRanges;
    allowedUDPPortRanges = config.allUDPPortRanges;
    extraCommands = lib.concatStringsSep "\n" config.allExtraCmds;
  };
}
