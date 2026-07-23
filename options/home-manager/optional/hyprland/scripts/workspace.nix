{
  homes,
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
  close =
    if homes.notify == "dunst"
    then "dunstctl close-all"
    else if homes.notify == "swaync"
    then "swaync-client --hide-all"
    else "";
in {
  home.file.".config/hypr/scripts/workspace.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      OLD_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')

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

      NEW_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')

      gamemode() {
        local mode="$1"
        if [[ $mode == "enable" ]]; then
          ~/.config/qmk/crkbd-toggle-game.py 1
          hyprctl eval "require('lib.util').enable_gamemode()"
          ${close}
          notify-send -e -a nosound -i state_running "Game Mode" "Activated"
        elif [[ $mode == "disable" ]]; then
          ~/.config/qmk/crkbd-toggle-game.py 0
          hyprctl eval "require('lib.util').disable_gamemode()"
          ${close}
          notify-send -e -a nosound -i state_paused "Game Mode" "Deactivated"
        fi
      }

      if [[ "$NEW_WORKSPACE" == "7" && "$OLD_WORKSPACE" != "7" ]]; then
        gamemode enable
      elif [[ "$NEW_WORKSPACE" != "7" && "$OLD_WORKSPACE" == "7" ]]; then
        gamemode disable
      else
        :
      fi

      if hyprctl workspaces | grep -q "workspace ID 7"; then
        :
      else
        if [ "$(hyprctl getoption debug:vfr -j | jq '.bool')" == "false" ]; then
          hyprctl eval "hl.config({debug={vfr=true}})"
        fi
      fi
    '';
  };
}
