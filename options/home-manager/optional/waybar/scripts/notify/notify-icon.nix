{
  homes,
  hosts,
  lib,
  ...
}: let
  dnd =
    if homes.notify == "dunst"
    then {
      on = "dunstctl set-paused true";
      off = ''
        dunstctl close-all
        dunstctl set-paused false
      '';
    }
    else if homes.notify == "swaync"
    then {
      on = "swaync-client -dn -sw";
      off = "swaync-client -df -sw";
    }
    else "";
in {
  home.file.".config/waybar/scripts/notify/notify-icon.sh" = lib.mkIf (homes.notify != "none") {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ICON_FILE="$HOME/.cache/${hosts.username}/notify-icon"
      VOLUME_FILE="$HOME/.cache/${hosts.username}/notify-volume"

      CURRENT_ICON=$(cat "$ICON_FILE")

      case $CURRENT_ICON in
      "󰂞")
        NEW_ICON="󰂚"
        echo "0" >"$VOLUME_FILE"
        ;;
      "󰂚")
        NEW_ICON="󰂛"
        ${dnd.on}
        ;;
      *)
        NEW_ICON="󰂞"
        ${dnd.off}
        echo "65536" >"$VOLUME_FILE"
        ;;
      esac

      echo "$NEW_ICON" >"$ICON_FILE"
      pkill -SIGRTMIN+10 waybar
    '';
  };
}
