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
  home.file.".config/waybar/scripts/control/output/cycle-output.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      CURRENT_SINK=$(pactl get-default-sink)
      mapfile -t SINKS < <(pactl list short sinks | awk '{print $2}' | grep -vE 'wl-screenrec|virtual')

      if [[ ''${#SINKS[@]} -eq 0 ]]; then
        ${close}
        notify-send -e -u critical "Cycle Output" "No audio output found!" -i audio-volume-high
        exit 1
      fi

      if [[ ''${#SINKS[@]} -eq 1 ]]; then
        ${close}
        notify-send -e "Cycle Output" "Only 1 audio output found!" -i audio-volume-high
        exit 0
      fi

      for i in "''${!SINKS[@]}"; do
        if [[ "''${SINKS[$i]}" == "$CURRENT_SINK" ]]; then
          CURRENT_INDEX=$i
          break
        fi
      done

      NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ''${#SINKS[@]} ))
      pactl set-default-sink "''${SINKS[$NEXT_INDEX]}"
      ${close}
      notify-send -e "Cycle Output" "''${SINKS[$NEXT_INDEX]}" -i audio-volume-high

      sleep 0.1
      pkill -SIGRTMIN+13 waybar
    '';
  };
}
