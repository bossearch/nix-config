{
  homes,
  hosts,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/notify/notify-icon.sh" = lib.mkIf homes.mako {
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
        makoctl mode -a dnd
        ;;
      *)
        NEW_ICON="󰂞"
        makoctl dismiss -a
        makoctl mode -r dnd
        echo "65536" >"$VOLUME_FILE"
        ;;
      esac

      echo "$NEW_ICON" >"$ICON_FILE"
      pkill -SIGRTMIN+10 waybar
    '';
  };
}
