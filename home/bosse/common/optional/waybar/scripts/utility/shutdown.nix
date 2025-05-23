{...}: {
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
        sleep 1
        ddcutil setvcp D6 05
        systemctl --quiet --no-warn poweroff
      #else
      #  echo "Shutdown canceled."
      fi
    '';
  };
}
