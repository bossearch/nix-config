{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/control/input/toggle-input.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      CURRENT_SOURCE=$(pactl get-default-source)
      SOURCE_STATUS=$(pactl get-source-mute "$CURRENT_SOURCE" | awk '{print $2}')

      if [ "$SOURCE_STATUS" = "yes" ]; then
        pactl set-source-mute "$CURRENT_SOURCE" 0
        notify-send -e "Input Unmuted" "$CURRENT_SOURCE" -i microphone-sensitivity-high
      else
        pactl set-source-mute "$CURRENT_SOURCE" 1
        notify-send -e "Input Muted" "$CURRENT_SOURCE" -i microphone-sensitivity-high
      fi

      sleep 0.1
      pkill -SIGRTMIN+14 waybar
    '';
  };
}
