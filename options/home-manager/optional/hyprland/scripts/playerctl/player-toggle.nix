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
      mapfile -t AVAILABLE_PLAYERS < <(playerctl -l 2>/dev/null)

      toggle_player() {
        playerctl -p "$NEXT_PLAYER" play-pause
        sleep 0.001

        STATUS=$(playerctl -p "$NEXT_PLAYER" status 2>/dev/null)
        if [ "$STATUS" == "Playing" ]; then
          ICON="media-playback-start"
        else
          ICON="media-playback-pause"
        fi
        ${close}
      }

      if [ "''${#AVAILABLE_PLAYERS[@]}" -eq 0 ]; then
        ${close}
        notify-send -e -a playerctl "Playerctl" "No media players found" -i dialog-warning
        exit 0
      elif [ "''${#AVAILABLE_PLAYERS[@]}" -eq 1 ]; then
        if [ "''${AVAILABLE_PLAYERS[0]}" != "$(cat "$PLAYER_FILE")" ]; then
          "$HOME/.config/hypr/scripts/playerctl/playerctl.sh silent"
          toggle_player
          notify-send -e -a playerctl "Playerctl" "''${AVAILABLE_PLAYERS[0]} - $STATUS" -i "$ICON"
        else
          NEXT_PLAYER="''${AVAILABLE_PLAYERS[0]}"
          toggle_player
          notify-send -e -a playerctl "Playerctl" "$NEXT_PLAYER - $STATUS" -i "$ICON"
        fi
      else
        NEXT_PLAYER="$(cat "$PLAYER_FILE")"
        toggle_player
        notify-send -e -a playerctl "Playerctl" "$NEXT_PLAYER - $STATUS" -i "$ICON"
      fi
    '';
  };
}
