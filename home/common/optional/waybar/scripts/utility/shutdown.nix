{pkgs, ...}: {
  home.file.".config/waybar/scripts/utility/shutdown.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      zenity --question \
        --title="System Shutdown" \
        --text="Are you sure you want to shutdown your system?" \
        --width=200 \
        --icon-name=system-shutdown

      if [ $? -eq 0 ]; then
        SOCKET=''${SOCKET:-''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/tmux-$(id -u)/default}
        tmux -S "$SOCKET" run-shell -b '${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh'
        sleep 1

        tmux -S "$SOCKET" kill-server
        sleep 1

        MPV_SOCKET="/tmp/mpv-socket"
        echo '{ "command": ["quit"] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"
        sleep 1

        HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
        hyprctl --batch "$HYPRCMDS"
        sleep 1

        ddcutil setvcp D6 05
        systemctl --quiet --no-warn poweroff
      fi
    '';
  };
}
