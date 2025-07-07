{config, ...}: {
  home.file.".config/waybar/scripts/screenrecord/checkrec.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Path to the icon file
      SCREENRECORD_ICON="$HOME/.cache/${config.spec.userName}/screenrecord-icon"

      # Get content from tooltip file
      SCREENRECORD_TOOLTIP=$(cat "$HOME/.cache/${config.spec.userName}/screenrecord-tooltip")

      # Define icons
      icon_recording=""
      icon_alternate="󰻂"

      # Check if wl-screenrec is running and display the appropriate icon
      if pgrep wl-screenrec >/dev/null; then
        current_icon=$(cat "$SCREENRECORD_ICON")
        # Determine the next icon to display
        if [ "$current_icon" = "$icon_recording" ]; then
          next_icon="$icon_alternate"
        else
          next_icon="$icon_recording"
        fi

        # Update the state file with the new icon
        echo "$next_icon" >"$SCREENRECORD_ICON"
        echo "{\"class\": \"recording\", \"text\": \"$next_icon\", \"tooltip\": \"$SCREENRECORD_TOOLTIP\"}"
      else
        exit
      fi
    '';
  };
}
