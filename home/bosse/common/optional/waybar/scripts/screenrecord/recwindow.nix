{
  home.file.".config/waybar/scripts/screenrecord/recwindow.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      # Ensure the screenshots directory exists
      mkdir -p ~/Videos//Screenrecords

      # For sourcing looper.sh
      SCRIPT_DIR="$(dirname "$(realpath "$0")")"

      # Define tooltip file location
      SCREENRECORD_TOOLTIP="$HOME/.cache/bosse/screenrecord-tooltip"

      # Get the active window's geometry using hyprctl
      WINDOW=$(hyprctl -j activewindow)
      TITLE=$(echo "$WINDOW" | jq -r '.initialTitle')
      X=$(echo "$WINDOW" | jq '.at[0]')
      Y=$(echo "$WINDOW" | jq '.at[1]')
      WIDTH=$(echo "$WINDOW" | jq '.size[0]')
      HEIGHT=$(echo "$WINDOW" | jq '.size[1]')

      # Define the filename with the current date and time
      FILENAME="$HOME/Videos/Screenrecords/$TITLE-$(date +%F_%T).mp4"

      # Check if valid data is retrieved
      if [ -z "$TITLE" ] || [ -z "$X" ] || [ -z "$Y" ] || [ -z "$WIDTH" ] || [ -z "$HEIGHT" ]; then
        echo "Error: Could not retrieve active window information."
        exit 1
      fi

      # Define the geometry string for wl-screenrec
      GEOMETRY="''${X},''${Y} ''${WIDTH}x''${HEIGHT}"

      # Create or update tooltip file for checkrec.sh
      echo "Screenrecording on $TITLE" > "$SCREENRECORD_TOOLTIP"

      # Notify the user that the recording is about to start
      notify-send -a screenrecord "Screenrecording on $TITLE Will start in 3 seconds " -t 2500
      sleep 3

      # Start recording the active window
      wl-screenrec --audio --low-power=off --no-damage -g "$GEOMETRY" -f "$FILENAME" & "$SCRIPT_DIR/looper.sh"

      # When the script finishes (e.g., with CTRL+C), notify the user
      trap 'dunstify "Screenrecord saved to $FILENAME" -t 3000' EXIT
    '';
  };
}
