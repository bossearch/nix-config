{...}: {
  home.file.".config/waybar/scripts/pavucontrol/toggle-input.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      # Get the microphone source ID
      CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -d ' ' -f 3)

      # Get the current mute state (0 for unmuted, 1 for muted)
      MUTE_STATE=$(pactl get-source-mute $CURRENT_SOURCE | awk '{print $2}')

      # Toggle the mute state
      if [ "$MUTE_STATE" = "yes" ]; then
        pactl set-source-mute $CURRENT_SOURCE 0
        notify-send "Microphone Unmuted"
      else
        pactl set-source-mute $CURRENT_SOURCE 1
        notify-send "Microphone Muted"
      fi

      # Optional: Restart the status bar or any other application that needs to be notified
      sleep 0.1
      pkill -SIGRTMIN+14 waybar
    '';
  };
}
