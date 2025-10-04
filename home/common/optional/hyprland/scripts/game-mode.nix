{config, ...}: {
  home.file.".config/hypr/scripts/game-mode.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      current_workspace=$(hyprctl activewindow | grep "workspace: " | sed -E 's/.*workspace: .*\((.*)\)/\1/')
      gamemode_file=~/.cache/${config.spec.userName}/gamemode

      apply_gamemode() {
        hyprctl --batch "\
          keyword unbind CONTROL, Q;\
          keyword unbind CONTROL, SPACE;\
          keyword unbind CONTROL, mouse:273;\
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
        if [ "$current_workspace" = "special:gamespace" ]; then
          hyprctl dispatch togglespecialworkspace gamespace
        fi
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
