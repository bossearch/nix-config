{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/cycle.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      LAYOUT=$(hyprctl activeworkspace -j | jq -r '.tiledLayout')

      if [[ "$LAYOUT" == "scrolling" ]]; then
        hyprctl dispatch cyclenext tiled "$1"
      else
        hyprctl dispatch layoutmsg cycle"$1"
      fi
    '';
  };
}
