{
  homes,
  hosts,
  lib,
  ...
}: let
  source =
    if hosts.hostname == "silvia"
    then ''
      DESK_MIC="alsa_input.pci-0000_08_00.6.analog-stereo"
      WEBCAM_MIC="alsa_input.usb-046d_Brio_100_2603AP74QPC8-02.mono-fallback"
      TWS_MIC="bluez_input.00:A4:1C:F9:15:84"

      if [[ "$CURRENT_SOURCE" == "$DESK_MIC" && "$MUTE_STATE" == "no" ]]; then
        echo "{\"text\": \"\"}"
      elif [[ "$CURRENT_SOURCE" == "$DESK_MIC" && "$MUTE_STATE" == "yes" ]]; then
        echo "{\"text\": \"\"}"
      elif [[ "$CURRENT_SOURCE" == "$WEBCAM_MIC" && "$MUTE_STATE" == "no" ]]; then
        echo "{\"text\": \"\"}"
      elif [[ "$CURRENT_SOURCE" == "$WEBCAM_MIC" && "$MUTE_STATE" == "yes" ]]; then
        echo "{\"text\": \"\"}"
      elif [[ "$CURRENT_SOURCE" == "$TWS_MIC" && "$MUTE_STATE" == "no" ]]; then
        echo "{\"text\": \"󰂯\"}"
      elif [[ "$CURRENT_SOURCE" == "$TWS_MIC" && "$MUTE_STATE" == "yes" ]]; then
        echo "{\"text\": \"󰂯\"}"
      else
        echo "{\"text\": \"?\"}"
      fi
    ''
    else ''
      if [[ "$MUTE_STATE" == "no" ]]; then
        echo "{\"text\": \"\"}"
      if [[ "$MUTE_STATE" == "yes" ]]; then
        echo "{\"text\": \"\"}"
      else
        echo "{\"text\": \"?\"}"
      fi
    '';
in {
  home.file.".config/waybar/scripts/control/input/mic-status.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      for i in {1..10}; do
        if pactl info &>/dev/null; then
          break
        fi
        sleep 1
      done

      CURRENT_SOURCE=$(pactl get-default-source)
      MUTE_STATE=$(pactl get-source-mute $CURRENT_SOURCE | awk '{print $2}')

      ${source}
    '';
  };
}
