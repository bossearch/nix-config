{config, ...}: {
  home.file.".config/waybar/scripts/screenrecord/recarea.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      mkdir -p ~/Videos//Screenrecords

      TRAY="$HOME/.config/waybar/scripts/utility/tray-trigger.sh wl-screenrec"
      PLAYBACK="$HOME/.config/waybar/scripts/screenrecord/playback.sh"
      FILENAME="$HOME/Videos/Screenrecords/Area-$(date +%F_%T).mp4"
      SCREENRECORD_TOOLTIP="$HOME/.cache/${config.spec.userName}/screenrecord-tooltip"
      GEOMETRY=$(slurp)

      if [ -z "$GEOMETRY" ]; then
        echo "Error: No area selected."
        exit 1
      fi

      read -r BUTTON COMMAND < <("$PLAYBACK")
      echo "Button code: $BUTTON"
      echo "wl-screenrec $COMMAND"

      if [[ "$BUTTON" -eq 0 ]]; then
        echo "Screenrecording on Area: $GEOMETRY" > "$SCREENRECORD_TOOLTIP"
        notify-send -a screenrecord "Screenrecording on Area: $GEOMETRY will start in 3 seconds" -t 2500
        sleep 3
        eval "wl-screenrec $COMMAND --low-power=off --no-damage -g \"$GEOMETRY\" -f \"$FILENAME\" & $TRAY"
        trap 'dunstify "Screenrecord saved to $FILENAME" -t 3000' EXIT
      else
        notify-send -a screenrecord --urgency=critical "Screenrecord Cancelled"
        exit 0
      fi

    '';
  };
}
