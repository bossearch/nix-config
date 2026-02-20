{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/game-mode.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      current_workspace=$(hyprctl activewindow | grep "workspace: " | sed -E 's/.*workspace: .*\((.*)\)/\1/')
      gamemode_file=~/.cache/${hosts.username}/gamemode

      apply_gamemode() {
        hyprctl --batch "\
          keyword unbind CONTROL, Q;\
          keyword unbind CONTROL, SPACE;\
          keyword unbind $meh, C "\
          keyword unbind $meh, E "\
          keyword unbind $meh, I "\
          keyword unbind $meh, O "\
          keyword unbind $meh, Q "\
          keyword unbind $meh, R "\
          keyword unbind $meh, U "\
          keyword unbind $meh, V "\
          keyword unbind $meh, W "\
          keyword unbind $meh, Y "\
          keyword unbind $hyper, B "\
          keyword unbind $hyper, C "\
          keyword unbind $hyper, E "\
          keyword unbind $hyper, I "\
          keyword unbind $hyper, O "\
          keyword unbind $hyper, Q "\
          keyword unbind $hyper, U "\
          keyword unbind $hyper, V "\
          keyword unbind $hyper, W "\
          keyword unbind $hyper, Y "\
          keyword unbind $meh, mouse:272 "\
          keyword unbind $meh, mouse:273 "\
          keyword unbind $hyper, mouse_down "\
          keyword unbind $hyper, mouse_up "\
          keyword unbind $hyper, mouse:272 "\
          keyword unbind $hyper, mouse:273 "\
          keyword decoration:blur:enabled 0;\
          keyword decoration:active_opacity 1;\
          keyword decoration:inactive_opacity 1;\
          keyword decoration:rounding 0"
      }

      activate_gamemode() {
        if [ "$current_workspace" != "special:gamespace" ]; then
          hyprctl dispatch togglespecialworkspace gamespace
        fi
        apply_gamemode
        touch "$gamemode_file"
        notify-send -a game_on "Game Mode" "Activated"
      }

      deactivate_gamemode() {
        # if [ "$current_workspace" = "special:gamespace" ]; then
        #   hyprctl dispatch togglespecialworkspace gamespace
        # fi
        hyprctl reload
        rm -f "$gamemode_file"
        notify-send -a game_off "Game Mode" "Deactivated"
      }

      if [ -f "$gamemode_file" ]; then
        deactivate_gamemode
      else
        activate_gamemode
      fi
    '';
  };
}
