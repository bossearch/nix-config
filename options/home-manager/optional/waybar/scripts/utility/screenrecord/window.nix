{
  homes,
  hosts,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/screenrecord/window.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      mkdir -p ~/Videos//Screenrecords
      TRAY="$HOME/.config/waybar/scripts/tray/tray-trigger.sh wl-screenrec"
      PLAYBACK="$HOME/.config/waybar/scripts/utility/screenrecord/playback.sh"
      SCREENRECORD_TOOLTIP="$HOME/.cache/${hosts.username}/screenrecord-tooltip"
      WINDOW=$(hyprctl -j activewindow)
      DATA=$(echo "$WINDOW" | jq -e -r '.initialTitle, .at[0], .at[1], .size[0], .size[1] | select(. != null)')

      if [ "$(echo "$DATA" | wc -l)" -ne 5 ]; then
        notify-send -e -u critical "Screenrecord Window" "Error: Could not retrieve active window information." -i camera-video
        exit 1
      fi

      read -r TITLE X Y WIDTH HEIGHT <<<"$(echo "$DATA" | tr '\n' ' ')"

      FILENAME="$HOME/Videos/Screenrecords/$(date +%F_%T)-$TITLE.mp4"

      GEOMETRY="''${X},''${Y} ''${WIDTH}x''${HEIGHT}"

      read -r BUTTON COMMAND < <("$PLAYBACK")

      if [[ "$BUTTON" -eq 0 ]]; then
        echo "Screenrecording on $TITLE Window" > "$SCREENRECORD_TOOLTIP"
        notify-send -e -a screenrecord "Screenrecord Window" "On $TITLE Will start in 3 seconds " -t 2500 -i camera-video
        sleep 3
        eval "wl-screenrec $COMMAND --low-power=off --no-damage -g \"$GEOMETRY\" -f \"$FILENAME\" & $TRAY"
        trap 'notify-send "Screenrecord Window" "File saved to $FILENAME" -i camera-video' EXIT
      else
        notify-send -e -u critical "Screenrecord Window" "Error: Cancelled" -i camera-video
        exit 0
      fi

    '';
  };
}
