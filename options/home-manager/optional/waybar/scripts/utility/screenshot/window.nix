{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/screenshot/window.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      mkdir -p ~/Pictures/Screenshots
      WINDOW=$(hyprctl -j activewindow)
      DATA=$(echo "$WINDOW" | jq -e -r '.initialTitle, .at[0], .at[1], .size[0], .size[1] | select(. != null)')

      if [ "$(echo "$DATA" | wc -l)" -ne 5 ]; then
        notify-send -e -u critical "Screenshot Window" "Error: Could not retrieve active window information." -i camera-photo
        exit 1
      fi

      read -r TITLE X Y WIDTH HEIGHT <<<"$(echo "$DATA" | tr '\n' ' ')"

      FILENAME="$HOME/Pictures/Screenshots/$(date +%F_%T)-$TITLE.png"

      grim -g "''${X},''${Y} ''${WIDTH}x''${HEIGHT}" - | wl-copy >"$FILENAME"

      notify-send -a screenshot "Screenshot Window" "File saved to $FILENAME" -i camera-photo
    '';
  };
}
