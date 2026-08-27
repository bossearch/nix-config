{hosts, ...}: let
  enabled = hosts.gui.enable && hosts.hostname == "silvia";
in {
  programs = {
    gamemode = {
      enable = enabled;
      settings = {
        general = {
          renice = 10;
        };
      };
    };
  };
}
