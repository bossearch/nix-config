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

      if matches "$CURRENT_SOURCE" "$DESK_MIC"; then
        if [[ "$MUTE_STATE" == "no" ]]; then
          ICON=" "
        elif [[ "$MUTE_STATE" == "yes" ]]; then
          ICON=" "
        fi

      elif matches "$CURRENT_SOURCE" "$WEBCAM_MIC"; then
        if [[ "$MUTE_STATE" == "no" ]]; then
          ICON=" "
        elif [[ "$MUTE_STATE" == "yes" ]]; then
          ICON=" "
        fi

      elif matches "$CURRENT_SOURCE" "$TWS_MIC"; then
        if [[ "$MUTE_STATE" == "no" ]]; then
          ICON="󰂯 "
        elif [[ "$MUTE_STATE" == "yes" ]]; then
          ICON="󰂯 "
        fi
      fi
    ''
    else ''
      if [[ "$MUTE_STATE" == "no" ]]; then
        ICON=" "
      elif [[ "$MUTE_STATE" == "yes" ]]; then
        ICON=" "
      fi
    '';
in {
  home.file.".config/waybar/scripts/control/input/mic-status.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      export LC_ALL=C

      matches() {
        [[ "$1" == "$2" || "$1" == "$2".* ]]
      }

      CURRENT_SOURCE=$(pactl get-default-source 2>/dev/null)

      if [[ -z "$CURRENT_SOURCE" || "$CURRENT_SOURCE" == "auto_null" ]] ||
        ! pactl get-source-mute "$CURRENT_SOURCE" &>/dev/null ||
        ! pactl get-source-volume "$CURRENT_SOURCE" &>/dev/null; then
        printf '{"text": "?"}\n'
        exit 0
      fi

      MUTE_STATE=$(LC_ALL=C pactl get-source-mute "$CURRENT_SOURCE" | awk '{print $2}')
      VOL=$(LC_ALL=C pactl get-source-volume "$CURRENT_SOURCE" | awk -F'/' '/Volume:/ {print $2}' | tr -d ' \t%' | head -n1)

      [[ -z "$VOL" ]] && VOL=0

      ICON="? "

      ${source}

      echo "{\"text\": \"$ICON$VOL%\"}"
    '';
  };
}
