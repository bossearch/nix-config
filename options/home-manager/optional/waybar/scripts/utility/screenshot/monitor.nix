{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/screenshot/monitor.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      mkdir -p ~/Pictures/Screenshots
      OUTPUT=$(hyprctl -j monitors | jq -r '.[0].name')
      FILENAME="$HOME/Pictures/Screenshots/$(date +%F_%T)-$OUTPUT.png"

      grim - | wl-copy >"$FILENAME"

      notify-send -a screenshot "Screenshot Monitor" "File saved to $FILENAME" -i camera-photo
    '';
  };
}
