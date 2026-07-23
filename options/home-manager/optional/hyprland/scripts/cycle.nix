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
        hyprctl eval "require('lib.util').cycle_window('scrolling', '$1')"
      else
        hyprctl eval "require('lib.util').cycle_window('not_scrolling', '$1')"
      fi
    '';
  };
}
