{pkgs, ...}: {
  home.file.".config/waybar/scripts/utility/reboot.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      zenity --question \
        --title="System Reboot" \
        --text="Are you sure you want to reboot your system?" \
        --width=200 \
        --icon-name=system-restart

      if [ $? -eq 0 ]; then
        SOCKET=''${SOCKET:-/tmp/tmux-$(id -u)/default}
        tmux -S "$SOCKET" run-shell -b '${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/save.sh'
        sleep 1

        tmux -S "$SOCKET" kill-server
        sleep 1

        HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
        hyprctl --batch "$HYPRCMDS"
        sleep 1

        systemctl --quiet --no-warn reboot
      fi
    '';
  };
}
