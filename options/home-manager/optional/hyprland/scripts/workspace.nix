{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/workspace.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      if [[ "$1" == "focus" ]]; then
        if [[ "$2" == "next" ]]; then
          hyprctl eval "require('lib.util').cycle_workspace('next')"
        elif [[ "$2" == "prev" ]]; then
          hyprctl eval "require('lib.util').cycle_workspace('prev')"
        else
          hyprctl eval "require('lib.util').select_workspace($2)"
        fi
      elif [[ "$1" == "move" ]]; then
        if [[ "$2" == "next" ]]; then
          hyprctl eval "require('lib.util').move_to_workspace('next')"
        elif [[ "$2" == "prev" ]]; then
          hyprctl eval "require('lib.util').move_to_workspace('prev')"
        else
          hyprctl eval "require('lib.util').move_to_selected_workspace($2)"
        fi
      fi
    '';
  };
}
