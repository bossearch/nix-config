{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/screenshot/window.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      WINDOW=$(hyprctl -j activewindow)
      DATA=$(echo "$WINDOW" | jq -r '"\(.initialTitle)|\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
      IFS='|' read -r TITLE GEOMETRY <<<"$DATA"

      if [ -z "$TITLE" ] || [ -z "$GEOMETRY" ]; then
        notify-send -e -u critical "Screenshot Window" "Error: Could not retrieve active window information." -i camera-photo
        exit 1
      fi

      FILENAME="$HOME/Pictures/Screenshots/$(date +%F_%T)-$TITLE.png"
      grim -g "$GEOMETRY" - | wl-copy && wl-paste >"$FILENAME"
      notify-send -a screenshot "Screenshot Window" "File saved to $FILENAME" -i camera-photo
    '';
  };
}
