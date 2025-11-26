{config, ...}: {
  home.file.".config/waybar/scripts/screenrecord/recmonitor.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      mkdir -p ~/Videos/Screenrecords

      TRAY="$HOME/.config/waybar/scripts/screenrecord/tray.sh"
      PLAYBACK="$HOME/.config/waybar/scripts/screenrecord/playback.sh"
      OUTPUT=$(hyprctl -j monitors | jq -r '.[0].name')
      FILENAME="$HOME/Videos/Screenrecords/$OUTPUT-$(date +%F_%T).mp4"
      SCREENRECORD_TOOLTIP="$HOME/.cache/${config.spec.userName}/screenrecord-tooltip"

      read -r BUTTON COMMAND < <("$PLAYBACK")
      echo "Button code: $BUTTON"
      echo "wl-screenrec $COMMAND"

      if [[ "$BUTTON" -eq 0 ]]; then
        echo "Screenrecording on Monitor: $OUTPUT" >"$SCREENRECORD_TOOLTIP"
        notify-send -a screenrecord "Screenrecording on Monitor: $OUTPUT will start in 3 seconds" -t 2500
        sleep 3
        eval "wl-screenrec $COMMAND --low-power=off --no-damage -o \"$OUTPUT\" -f \"$FILENAME\" & $TRAY"
        trap 'notify-send "Screenrecord saved to $FILENAME" -t 3000' EXIT
      else
        notify-send -a screenrecord --urgency=critical "Screenrecord Cancelled"
        exit 0
      fi
    '';
  };
}
