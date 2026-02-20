{
  homes,
  lib,
  pkgs,
  ...
}: {
  home.file.".config/waybar/scripts/utility/shutdown.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      zenity --question \
        --title="System Shutdown" \
        --text="Are you sure you want to shutdown your system?" \
        --width=200 \
        --icon=system-shutdown

      if [ $? -eq 0 ]; then
        for NVIM_SOCK in /run/user/1000/nvim.*; do
          if [[ -S "$NVIM_SOCK" ]]; then
            nvim --server "$NVIM_SOCK" --remote-send \
              "<C-\\><C-N>:lua require('mini.sessions').write('global-session')<CR>"
          fi
        done
        sleep 1

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
