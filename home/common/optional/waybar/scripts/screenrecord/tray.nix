{config, ...}: {
  home.file.".config/waybar/scripts/screenrecord/tray.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      SCREENRECORD_TOOLTIP=$(cat "$HOME/.cache/${config.spec.userName}/screenrecord-tooltip")

      ICON_1="<span foreground=\\\"#${config.colorScheme.palette.base08}\\\"></span>"
      ICON_2="<span foreground=\\\"#FFFFFF\\\">󰻂</span>"

      PID=$(pgrep -o wl-screenrec) || exit 0

      START_TIME=$(stat -c %Y /proc/"$PID")
      NOW=$(date +%s)

      ELAPSED=$((NOW - START_TIME))

      if ((ELAPSED % 2 == 0)); then
        ICON="$ICON_1"
      else
        ICON="$ICON_2"
      fi

      echo "{\"class\": \"recording\", \"text\": \"$ICON\", \"tooltip\": \"$SCREENRECORD_TOOLTIP\"}"
    '';
  };
}
