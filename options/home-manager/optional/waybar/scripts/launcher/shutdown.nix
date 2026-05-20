{
  homes,
  lib,
  pkgs,
  ...
}: {
  home.file.".config/waybar/scripts/launcher/shutdown.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      if zenity --question \
        --title="System Shutdown" \
        --text="Are you sure you want to shutdown your system?" \
        --width=200 \
        --icon=system-shutdown; then

        for NVIM_SOCKET in /run/user/1000/nvim.*; do
          if [[ -S "$NVIM_SOCKET" ]]; then
            nvim --server "$NVIM_SOCKET" --remote-send \
              "<C-\\><C-N>:lua require('mini.sessions').write('global-session')<CR>"
          fi
        done
        sleep 1

        TMUX_SOCKET="$XDG_RUNTIME_DIR/tmux-$(id -u)/default"
        tmux -S "$TMUX_SOCKET" run-shell -b '${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh'
        sleep 1

        tmux -S "$TMUX_SOCKET" kill-server
        sleep 1

        MPV_SOCKET="/tmp/mpv-socket"
        echo '{ "command": ["quit"] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"
        sleep 1

        systemd-run --user --remain-after-exit \
          bash -c "hyprshutdown -p 'ddcutil setvcp D6 05; poweroff' -t 'Shutting down...'"
      else
        :
      fi
    '';
  };
}
