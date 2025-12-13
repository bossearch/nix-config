{config, ...}: {
  home.file.".config/waybar/scripts/screenrecord/recwindow.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      mkdir -p ~/Videos//Screenrecords

      TRAY="$HOME/.config/waybar/scripts/utility/tray-trigger.sh wl-screenrec"
      PLAYBACK="$HOME/.config/waybar/scripts/screenrecord/playback.sh"
      SCREENRECORD_TOOLTIP="$HOME/.cache/${config.spec.userName}/screenrecord-tooltip"
      WINDOW=$(hyprctl -j activewindow)
      TITLE=$(echo "$WINDOW" | jq -r '.initialTitle')
      X=$(echo "$WINDOW" | jq '.at[0]')
      Y=$(echo "$WINDOW" | jq '.at[1]')
      WIDTH=$(echo "$WINDOW" | jq '.size[0]')
      HEIGHT=$(echo "$WINDOW" | jq '.size[1]')
      FILENAME="$HOME/Videos/Screenrecords/$TITLE-$(date +%F_%T).mp4"

      if [ -z "$TITLE" ] || [ -z "$X" ] || [ -z "$Y" ] || [ -z "$WIDTH" ] || [ -z "$HEIGHT" ]; then
        echo "Error: Could not retrieve active window information."
        exit 1
      fi

      GEOMETRY="''${X},''${Y} ''${WIDTH}x''${HEIGHT}"

      read -r BUTTON COMMAND < <("$PLAYBACK")
      echo "Button code: $BUTTON"
      echo "wl-screenrec $COMMAND"

      if [[ "$BUTTON" -eq 0 ]]; then
        echo "Screenrecording on $TITLE" > "$SCREENRECORD_TOOLTIP"
        notify-send -a screenrecord "Screenrecording on $TITLE Will start in 3 seconds " -t 2500
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
