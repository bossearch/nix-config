{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/pavucontrol/toggle-output.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -e

      # Get the default sink ID
      CURRENT_SINK=$(pactl get-default-sink)

      # Get the current mute state (0 for unmuted, 1 for muted)
      SINK_STATUS=$(pactl get-sink-mute $CURRENT_SINK | awk '{print $2}')

      # Toggle the mute state
      if [ "$SINK_STATUS" = "yes" ]; then
        pactl set-sink-mute $CURRENT_SINK 0
        notify-send "Output Unmuted"
      else
        pactl set-sink-mute $CURRENT_SINK 1
        notify-send "Output Muted"
      fi
    '';
  };
}
