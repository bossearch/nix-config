{...}: {
  home.file.".config/waybar/scripts/screenshot/ssarea.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      # Ensure the screenshots directory exists
      mkdir -p ~/Pictures/Screenshots

      # Define the filename with the current date and time
      FILENAME="$HOME/Pictures/Screenshots/Area-$(date +%F_%T).png"

      # Use slurp to select an area
      GEOMETRY=$(slurp)

      # Start screenshot the area
      grim -g "$GEOMETRY" - | wl-copy && wl-paste > $FILENAME

      # Notify the user that the Screenshot has done

      notify-send -a screenshot "Screenshot saved to $FILENAME" -t 3000
    '';
  };
}
