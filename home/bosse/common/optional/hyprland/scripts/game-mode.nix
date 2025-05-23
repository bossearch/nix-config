{...}: {
  home.file.".config/hypr/scripts/game-mode.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      current_workspace=$(hyprctl activewindow | grep "workspace: " | sed -E 's/.*workspace: .*\((.*)\)/\1/')
      game_on="/home/bosse/.local/share/icons/Papirus/32x32/status/state_running.svg"
      game_off="/home/bosse/.local/share/icons/Papirus/32x32/status/state_paused.svg"

      if [ -f ~/.cache/gamemode ]; then
        hyprctl --batch "\
          dispatch togglespecialworkspace gamespace;\
          reload"
        rm ~/.cache/gamemode
        notify-send -a game-off "Game Mode" "Deactivated" -i "$game_off"
      else
        if [ "$current_workspace" = "special:gamespace" ]; then
          hyprctl --batch "\
            keyword unbind CONTROL, Q;\
            keyword unbind CONTROL, SPACE;\
            keyword unbind CONTROL, mouse:273;\
            keyword decoration:blur:enabled 0;\
            keyword decoration:active_opacity 1;\
            keyword decoration:inactive_opacity 1;\
            keyword decoration:rounding 0"
          touch ~/.cache/gamemode
          notify-send -a game-on "Game Mode" "Activated" -i "$game_on"
        else
          hyprctl --batch "\
            dispatch togglespecialworkspace gamespace;\
            keyword unbind CONTROL, Q;\
            keyword unbind CONTROL, SPACE;\
            keyword unbind CONTROL, mouse:273;\
            keyword decoration:blur:enabled 0;\
            keyword decoration:active_opacity 1;\
            keyword decoration:inactive_opacity 1;\
            keyword decoration:rounding 0"
          touch ~/.cache/gamemode
          notify-send -a game-on "Game Mode" "Activated" -i "$game_on"
        fi
      fi
    '';
  };
}
