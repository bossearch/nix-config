{
  homes,
  lib,
  ...
}: let
  close =
    if homes.notify == "dunst"
    then "dunstctl close-all"
    else if homes.notify == "swaync"
    then "swaync-client --hide-all"
    else "";
in {
  home.file.".config/waybar/scripts/control/output/toggle-output.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      CURRENT_SINK=$(pactl get-default-sink)
      SINK_STATUS=$(pactl get-sink-mute $CURRENT_SINK | awk '{print $2}')

      if [ "$SINK_STATUS" = "yes" ]; then
        pactl set-sink-mute $CURRENT_SINK 0
        ${close}
        notify-send -e "Output Unmuted" "$CURRENT_SINK" -i audio-volume-high
      else
        pactl set-sink-mute $CURRENT_SINK 1
        ${close}
        notify-send -e "Output Muted" "$CURRENT_SINK" -i audio-volume-high
      fi
    '';
  };
}
