{hosts, ...}: {
  programs.steam = {
    enable = hosts.steam;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    # gamescopeSession.enable = true;
  };
  programs.gamemode.enable = hosts.steam;
}
