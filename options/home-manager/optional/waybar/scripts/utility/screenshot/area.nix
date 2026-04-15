{
  config,
  homes,
  lib,
  ...
}: let
  background = "#${config.colorScheme.palette.base00}33";
  border = "#${config.colorScheme.palette.base05}ff";
in {
  home.file.".config/waybar/scripts/utility/screenshot/area.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      mkdir -p ~/Pictures/Screenshots
      FILENAME="$HOME/Pictures/Screenshots/$(date +%F_%T)-Area.png"
      GEOMETRY=$(slurp -d -F "${homes.nerdfont}" -b "${background}" -c "${border}")

      if [ -z "$GEOMETRY" ]; then
        notify-send -e -u critical "Screenshot Area" "Error: No area selected" -i camera-photo
        exit 1
      fi

      grim -g "$GEOMETRY" - | wl-copy >"$FILENAME"

      notify-send -a screenshot "Screenshot Area" "File saved to $FILENAME" -i camera-photo
    '';
  };
}
