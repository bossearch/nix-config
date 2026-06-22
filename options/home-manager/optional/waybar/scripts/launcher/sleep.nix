{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/launcher/sleep.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      if zenity --question \
        --title="System Sleep" \
        --text="Are you sure you want to sleep your system?" \
        --width=200 \
        --icon=sleep; then
        systemctl suspend
      else
        :
      fi
    '';
  };
}
