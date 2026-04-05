{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/control/input/mic-status.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Get the current default source (microphone)
      CURRENT_SOURCE=$(pactl get-default-source)

      # Get the current mute state (0 for unmuted, 1 for muted)
      MUTE_STATE=$(pactl get-source-mute $CURRENT_SOURCE | awk '{print $2}')

      # Mic list
      DESK_MIC="alsa_input.pci-0000_08_00.6.analog-stereo"
      TWS_MIC="bluez_input.00:A4:1C:F9:15:84"

      if [[ "$CURRENT_SOURCE" == "$DESK_MIC" && "$MUTE_STATE" == "no" ]]; then
        echo "{\"text\": \"\"}"
      elif [[ "$CURRENT_SOURCE" == "$DESK_MIC" && "$MUTE_STATE" == "yes" ]]; then
        echo "{\"text\": \"\"}"
      elif [[ "$CURRENT_SOURCE" == "$TWS_MIC" && "$MUTE_STATE" == "no" ]]; then
        echo "{\"text\": \"󰂯\"}"
      elif [[ "$CURRENT_SOURCE" == "$TWS_MIC" && "$MUTE_STATE" == "yes" ]]; then
        echo "{\"text\": \"󰂯\"}"
      fi

      sleep 0.1
      pkill -SIGRTMIN+14 waybar
    '';
  };
}
