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

      apply_gamemode() {
        hyprctl --batch "\
          keyword unbind CONTROL, Q;\
          keyword unbind CONTROL, SPACE;\
          keyword decoration:blur:enabled 0;\
          keyword decoration:active_opacity 1;\
          keyword decoration:inactive_opacity 1;\
          keyword decoration:rounding 0"
      }

      activate_gamemode() {
        ~/.config/qmk/crkbd-toggle-game.py 1
        apply_gamemode
        ${close}
        notify-send -e -a nosound -i state_running "Game Mode" "Activated"
      }

      deactivate_gamemode() {
        ~/.config/qmk/crkbd-toggle-game.py 0
        hyprctl reload
        ${close}
        notify-send -e -a nosound -i state_paused "Game Mode" "Deactivated"
      }

      if [[ "$NEW_WORKSPACE" == "7" && "$OLD_WORKSPACE" != "7" ]]; then
        activate_gamemode
      elif [[ "$NEW_WORKSPACE" != "7" && "$OLD_WORKSPACE" == "7" ]]; then
        deactivate_gamemode
      else
        :
      fi
    '';
  };
}
