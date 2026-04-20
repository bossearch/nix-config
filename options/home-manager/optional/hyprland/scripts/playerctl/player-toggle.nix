{
  homes,
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
  close =
    if homes.notify == "dunst"
    then "dunstctl close-all"
    else if homes.notify == "swaync"
    then "swaync-client --hide-all"
    else "";
in {
  home.file.".config/hypr/scripts/playerctl/player-toggle.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      PLAYER_FILE="$HOME/.cache/${hosts.username}/player"
      PLAYER="$(cat "$PLAYER_FILE")"

      playerctl -p "$PLAYER" play-pause

      STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)
      if [ "$STATUS" == "Playing" ]; then
        ICON="media-playback-start"
      else
        ICON="media-playback-pause"
      fi

      ${close}
      notify-send -e -a playerctl "$PLAYER" "$STATUS" -i "$ICON"
    '';
  };
}
