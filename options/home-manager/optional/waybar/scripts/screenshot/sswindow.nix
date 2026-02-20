{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/screenshot/sswindow.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      # Ensure the screenshots directory exists
      mkdir -p ~/Pictures/Screenshots

      # Get the active window information using hyprctl
      WINDOW=$(hyprctl -j activewindow)

      # Extract the window title, position, and size from the JSON
      TITLE=$(echo "$WINDOW" | jq -r '.initialTitle')
      X=$(echo "$WINDOW" | jq -r '.at[0]')
      Y=$(echo "$WINDOW" | jq -r '.at[1]')
      WIDTH=$(echo "$WINDOW" | jq -r '.size[0]')
      HEIGHT=$(echo "$WINDOW" | jq -r '.size[1]')

      # Define the filename with the current date and time
      FILENAME="$HOME/Pictures/Screenshots/$TITLE-$(date +%F_%T).png"

      # Check if valid data is retrieved
      if [ -z "$TITLE" ] || [ -z "$X" ] || [ -z "$Y" ] || [ -z "$WIDTH" ] || [ -z "$HEIGHT" ]; then
        echo "Error: Could not retrieve active window information." >&2
        exit 1
      fi

      # Take a screenshot of the focused window using grim
      grim -g "''${X},''${Y} ''${WIDTH}x''${HEIGHT}" - | wl-copy && wl-paste > "$HOME/Pictures/Screenshots/$TITLE-$(date +%F_%T).png"

      # Send a notification
      notify-send -a screenshot "Screenshot saved to $FILENAME" -t 3000
    '';
  };
}
