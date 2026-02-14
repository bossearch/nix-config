{config, ...}: {
  home.file.".config/waybar/scripts/hyprsunset/hyprsunset.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # File to store the current state
      ICON_FILE="$HOME/.cache/${config.spec.userName}/hyprsunset-icon"
      TEMP_FILE="$HOME/.cache/${config.spec.userName}/temperature"
      TEMP_SCROLL="$HOME/.cache/${config.spec.userName}/temp-scroll"

      # Read the current state
      CURRENT_TEMP=$(cat "$TEMP_FILE")

      # Toggle the temperature
      if [[ "$CURRENT_TEMP" == "6500" ]]; then
        echo "" >"$ICON_FILE"
        echo "2700" | tee "$TEMP_FILE" "$TEMP_SCROLL"
        pkill -SIGRTMIN+12 waybar
        hyprctl hyprsunset temperature 2700
      else
        echo "" >"$ICON_FILE"
        echo "6500" | tee "$TEMP_FILE" "$TEMP_SCROLL"
        pkill -SIGRTMIN+12 waybar
        hyprctl hyprsunset temperature 6500
      fi
    '';
  };
}
