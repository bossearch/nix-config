{
  homes,
  hosts,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/control/hyprsunset.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ICON_FILE="$HOME/.cache/${hosts.username}/hyprsunset-icon"
      TEMP_FILE="$HOME/.cache/${hosts.username}/hyprsunset-temp"

      CURRENT_TEMP=$(cat "$TEMP_FILE")

      if [[ "$CURRENT_TEMP" == "6500" ]]; then
        TOGGLE_STATE="enable"
      else
        TOGGLE_STATE="disable"
      fi

      STATE="''${1:-$TOGGLE_STATE}"

      if [[ "$CURRENT_TEMP" == "6500" ]] && [[ $STATE == "enable" ]]; then
        echo "󰈈" >"$ICON_FILE"
        echo "2700" >"$TEMP_FILE"
        pkill -SIGRTMIN+12 waybar
        hyprctl hyprsunset temperature 2700
      elif [[ "$CURRENT_TEMP" == "2700" ]] && [[ $STATE == "disable" ]]; then
        echo "" >"$ICON_FILE"
        echo "6500" >"$TEMP_FILE"
        pkill -SIGRTMIN+12 waybar
        hyprctl hyprsunset temperature 6500
      else
        :
      fi
    '';
  };
}
