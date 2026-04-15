{
  homes,
  hosts,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/screenrecord/monitor.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      mkdir -p ~/Videos/Screenrecords
      TRAY="$HOME/.config/waybar/scripts/tray/tray-trigger.sh wl-screenrec"
      PLAYBACK="$HOME/.config/waybar/scripts/utility/screenrecord/playback.sh"
      OUTPUT=$(hyprctl -j monitors | jq -r '.[0].name')
      FILENAME="$HOME/Videos/Screenrecords/$(date +%F_%T)-$OUTPUT.mp4"
      SCREENRECORD_TOOLTIP="$HOME/.cache/${hosts.username}/screenrecord-tooltip"

      read -r BUTTON COMMAND < <("$PLAYBACK")

      if [[ "$BUTTON" -eq 0 ]]; then
        echo "Screenrecording on $OUTPUT Monitor" > "$SCREENRECORD_TOOLTIP"
        notify-send -e -a screenrecord "Screenrecord Monitor" "On $OUTPUT will start in 3 seconds" -t 2500 -i camera-video
        sleep 3
        eval "wl-screenrec $COMMAND --low-power=off --no-damage -o \"$OUTPUT\" -f \"$FILENAME\" & $TRAY"
        trap 'notify-send "Screenrecord Monitor" "File saved to $FILENAME" -i camera-video' EXIT
      else
        notify-send -e -u critical "Screenrecord Monitor" "Error: Cancelled" -i camera-video
        exit 0
      fi
    '';
  };
}
