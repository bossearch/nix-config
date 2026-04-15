{
  config,
  homes,
  hosts,
  lib,
  ...
}: let
  background = "#${config.colorScheme.palette.base00}33";
  border = "#${config.colorScheme.palette.base05}ff";
in {
  home.file.".config/waybar/scripts/utility/screenrecord/area.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      mkdir -p ~/Videos//Screenrecords
      TRAY="$HOME/.config/waybar/scripts/tray/tray-trigger.sh wl-screenrec"
      PLAYBACK="$HOME/.config/waybar/scripts/utility/screenrecord/playback.sh"
      FILENAME="$HOME/Videos/Screenrecords/$(date +%F_%T)-Area.mp4"
      SCREENRECORD_TOOLTIP="$HOME/.cache/${hosts.username}/screenrecord-tooltip"
      GEOMETRY=$(slurp -d -F "${homes.nerdfont}" -b "${background}" -c "${border}")
      GEOMETRY_NEW=$(echo "$GEOMETRY" | sed 's/\(.*\) \(.*\)/"\1" size "\2"/')

      if [ -z "$GEOMETRY" ]; then
        notify-send -e -u critical "Screenrecord Area" "Error: No area selected" -i camera-video
        exit 1
      fi

      read -r BUTTON COMMAND < <("$PLAYBACK")

      if [[ "$BUTTON" -eq 0 ]]; then
        echo "Screenrecording on $GEOMETRY Area" > "$SCREENRECORD_TOOLTIP"
        notify-send -e -a screenrecord "Screenrecord Area" "On $GEOMETRY will start in 3 seconds" -t 2500 -i camera-video
        sleep 3
        eval "wl-screenrec $COMMAND --low-power=off --no-damage -g \"$GEOMETRY\" -f \"$FILENAME\" & $TRAY"
        trap 'notify-send "Screenrecord Area" "File saved to $FILENAME" -i camera-video' EXIT
      else
        notify-send -e -u critical "Screenrecord Area" "Error: Cancelled" -i camera-video
        exit 0
      fi

    '';
  };
}
