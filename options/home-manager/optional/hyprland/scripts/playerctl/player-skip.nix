{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/playerctl/player-skip.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      playerctl -p "$(cat ~/.cache/${hosts.username}/player)" "$@"
    '';
  };
}
