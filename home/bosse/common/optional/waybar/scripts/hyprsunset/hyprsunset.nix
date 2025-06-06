{
  home.file.".config/waybar/scripts/hyprsunset/hyprsunset.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # File to store the current state
      ICON_FILE="$HOME/.cache/bosse/hyprsunset-icon"
      TEMP_FILE="$HOME/.cache/bosse/temperature"
      TEMP_SCROLL="$HOME/.cache/bosse/temp-scroll"

      # Read the current state
      CURRENT_TEMP=$(cat "$TEMP_FILE")

      # Toggle the temperature
      if [[ "$CURRENT_TEMP" == "6500" ]]; then
        echo "  " >"$ICON_FILE"
        echo "2700" | tee "$TEMP_FILE" "$TEMP_SCROLL"
        pkill -SIGRTMIN+12 waybar
        hyprsunset -t 2700
      else
        echo "  " >"$ICON_FILE"
        echo "6500" | tee "$TEMP_FILE" "$TEMP_SCROLL"
        pkill -SIGRTMIN+12 waybar
        hyprsunset -t 6500
      fi
    '';
  };
}
