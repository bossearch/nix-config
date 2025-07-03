{
  home.file.".config/waybar/scripts/screenrecord/recarea.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      # Ensure the screenshots directory exists
      mkdir -p ~/Videos//Screenrecords

      # For sourcing looper.sh
      SCRIPT_DIR="$HOME/.config/waybar/scripts/screenrecord"

      # Define the filename with the current date and time
      FILENAME="$HOME/Videos/Screenrecords/Area-$(date +%F_%T).mp4"

      # Define tooltip file location
      SCREENRECORD_TOOLTIP="$HOME/.cache/bosse/screenrecord-tooltip"

      # Use slurp to select an area
      GEOMETRY=$(slurp)

      # Check if a valid area was selected
      if [ -z "$GEOMETRY" ]; then
        echo "Error: No area selected."
        exit 1
      fi

      # Create or update tooltip file for checkrec.sh
      echo "Screenrecording on Area: $GEOMETRY" > "$SCREENRECORD_TOOLTIP"

      # Notify the user that the recording has started
      notify-send -a screenrecord "Screenrecording on Area: $GEOMETRY will start in 3 seconds" -t 2500
      sleep 3

      # Start recording the entire monitor
      wl-screenrec --audio --low-power=off --no-damage -g "$GEOMETRY" -f "$FILENAME" & "$SCRIPT_DIR/looper.sh"

      # When the script finishes (e.g., with CTRL+C), notify the user
      trap 'dunstify "Screenrecord saved to $FILENAME" -t 3000' EXIT
    '';
  };
}
