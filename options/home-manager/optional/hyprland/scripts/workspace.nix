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

      if [[ "$2" == "next" ]]; then
        hyprctl dispatch "$1" e+1
      elif [[ "$2" == "prev" ]]; then
        hyprctl dispatch "$1" e-1
      else
        hyprctl dispatch "$1" "$2"
      fi

      NEW_WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')

      gamemode() {
        local mode="$1"
        if [[ $mode == "enable" ]]; then
          ~/.config/qmk/crkbd-toggle-game.py 1
          hyprctl --batch "\
            keyword decoration:blur:enabled 0;\
            keyword decoration:active_opacity 1;\
            keyword decoration:inactive_opacity 1;\
            keyword decoration:rounding 0;\
            keyword misc:vfr 0"
          ${close}
          notify-send -e -a nosound -i state_running "Game Mode" "Activated"
        elif [[ $mode == "disable" ]]; then
          ~/.config/qmk/crkbd-toggle-game.py 0
          hyprctl --batch "\
            keyword decoration:blur:enabled 1;\
            keyword decoration:active_opacity 0.9;\
            keyword decoration:inactive_opacity 0.85;\
            keyword decoration:rounding 8"
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
        if [ "$(hyprctl getoption misc:vfr -j | jq '.int')" -eq 0 ]; then
          hyprctl keyword debug:vfr 1
        fi
      fi
    '';
  };
}
