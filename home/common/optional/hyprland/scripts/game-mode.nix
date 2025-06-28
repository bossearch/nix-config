{pkgs, ...}: {
  home.file.".config/hypr/scripts/game-mode.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      current_workspace=$(hyprctl activewindow | grep "workspace: " | sed -E 's/.*workspace: .*\((.*)\)/\1/')

      if [ -f ~/.cache/gamemode ]; then
        hyprctl --batch "\
          dispatch togglespecialworkspace gamespace;\
          reload"
        rm ~/.cache/gamemode
        notify-send -a game_off "Game Mode" "Deactivated"
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
          notify-send -a game_on "Game Mode" "Activated"
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
          notify-send -a game_on "Game Mode" "Activated"
        fi
      fi
    '';
  };
}
