{
  home.file.".config/waybar/scripts/hyprsunset/scroll-up.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # File to store the actual (incremented) temperature
      TEMP_SCROLL="$HOME/.cache/bosse/temp-scroll"

      # Read the actual (incremented) temperature from the file
      temp_scroll_value=$(cat "$TEMP_SCROLL")

      # Increment the actual temperature by 100
      new_temp_scroll_value=$(echo "$temp_scroll_value + 100" | bc)

      # Save the new actual temperature back to the actual temp file
      echo "$new_temp_scroll_value" >"$TEMP_SCROLL"

      # Apply the new actual temperature using hyprsunset
      hyprsunset -t "$new_temp_scroll_value"
    '';
  };
}
