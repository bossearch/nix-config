{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/control/input/cycle-input.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      CURRENT_SOURCE=$(pactl get-default-source)
      mapfile -t SOURCES < <(pactl list short sources | awk '/alsa_input/ {print $2}')

      if [[ ''${#SOURCES[@]} -eq 0 ]]; then
        notify-send -e -u critical "Cycle Input" "No audio input found!" -i microphone-sensitivity-high
        exit 1
      fi

      if [[ ''${#SOURCES[@]} -eq 1 ]]; then
        notify-send -e "Cycle Input" "Only 1 audio input found!" -i microphone-sensitivity-high
        exit 0
      fi

      for i in "''${!SOURCES[@]}"; do
        if [[ "''${SOURCES[$i]}" == "$CURRENT_SOURCE" ]]; then
          CURRENT_INDEX=$i
          break
        fi
      done

      NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ''${#SOURCES[@]} ))
      pactl set-default-source "''${SOURCES[$NEXT_INDEX]}"
      notify-send -e "Cycle Input" "''${SOURCES[$NEXT_INDEX]}" -i microphone-sensitivity-high

      sleep 0.1
      pkill -SIGRTMIN+14 waybar
    '';
  };
}
