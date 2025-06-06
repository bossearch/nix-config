{
  home.file.".config/waybar/scripts/pavucontrol/toggle-output.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      # Get the default sink ID
      SINK_ID=$(pactl info | grep "Default Sink" | awk '{print $3}')

      # Get the current mute state (0 for unmuted, 1 for muted)
      MUTE_STATE=$(pactl get-sink-mute $SINK_ID | awk '{print $2}')

      # Toggle the mute state
      if [ "$MUTE_STATE" = "yes" ]; then
        pactl set-sink-mute $SINK_ID 0
        notify-send "Output Unmuted"
      else
        pactl set-sink-mute $SINK_ID 1
        notify-send "Output Muted"
      fi
    '';
  };
}
