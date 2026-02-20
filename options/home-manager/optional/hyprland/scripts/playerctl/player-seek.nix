{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/playerctl/player-seek.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      PLAYER=$(cat ~/.cache/${hosts.username}/player)
      CHANGE=$1  # e.g. +5 or -5

      current=$(playerctl --player="$PLAYER" position | cut -d '.' -f1)
      target=$(( current + CHANGE ))
      [[ $target -lt 0 ]] && target=0

      playerctl --player="$PLAYER" position "$target"
    '';
  };
}
