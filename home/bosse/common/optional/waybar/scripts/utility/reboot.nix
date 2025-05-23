{...}: {
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
        sleep 1
        systemctl --quiet --no-warn reboot
      #else
      #  echo "Restart canceled."
      fi
    '';
  };
}
