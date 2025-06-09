{
  home.file.".config/waybar/scripts/screenrecord/recmonitor.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      # Ensure the screenshots directory exists
      mkdir -p ~/Videos//Screenrecords

      # For sourcing looper.sh
      SCRIPT_DIR="$(dirname "$(realpath "$0")")"

      # Get the name of the monitor/output using hyprctl (default to the first monitor)
      OUTPUT=$(hyprctl -j monitors | jq -r '.[0].name')

      # Define the filename with the current date and time
      FILENAME="$HOME/Videos/Screenrecords/$OUTPUT-$(date +%F_%T).mp4"

      # Define tooltip file location
      SCREENRECORD_TOOLTIP="$HOME/.cache/bosse/screenrecord-tooltip"

      # Create or update tooltip file for checkrec.sh
      echo "Screenrecording on Monitor: $OUTPUT" > "$SCREENRECORD_TOOLTIP"

      # Notify the user that the recording has started
      notify-send -a screenrecord "Screenrecording on Monitor: $OUTPUT will start in 3 seconds" -t 2500
      sleep 3

      # Start recording the entire monitor
      wl-screenrec --audio --low-power=off --no-damage -o "$OUTPUT" -f "$FILENAME" & "$SCRIPT_DIR/looper.sh"

      # When the script finishes (e.g., with CTRL+C), notify the user
      trap 'dunstify "Screenrecord saved to $FILENAME" -t 3000' EXIT
    '';
  };
}
