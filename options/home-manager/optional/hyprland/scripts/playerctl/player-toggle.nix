{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable;
in {
  home.file.".config/hypr/scripts/playerctl/player-toggle.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      PLAYER_FILE="$HOME/.cache/${hosts.username}/player"
      mapfile -t AVAILABLE_PLAYERS < <(playerctl -l 2>/dev/null)

      toggle_player() {
        playerctl -p "$NEXT_PLAYER" play-pause
        sleep 0.05

        STATUS=$(playerctl -p "$NEXT_PLAYER" status 2>/dev/null)

        ICON="''${NEXT_PLAYER%%.*}"
        ICON="''${ICON,,}"

        makoctl dismiss -a
      }

      CURRENT_PLAYER=""
      if [ -f "$PLAYER_FILE" ]; then
        CURRENT_PLAYER=$(tr -d '\n' <"$PLAYER_FILE" | xargs)
      fi

      if [ "''${#AVAILABLE_PLAYERS[@]}" -eq 0 ]; then
        makoctl dismiss -a
        notify-send -e -a playerctl "Playerctl" "No media players found" -i dialog-warning
        exit 0
      elif [ "''${#AVAILABLE_PLAYERS[@]}" -eq 1 ]; then
        NEXT_PLAYER="''${AVAILABLE_PLAYERS[0]}"
        ICON="''${NEXT_PLAYER%%.*}"
        ICON="''${ICON,,}"
        if [ "$NEXT_PLAYER" != "$CURRENT_PLAYER" ]; then
          "$HOME/.config/hypr/scripts/playerctl/playerctl.sh" silent
        fi
        toggle_player
        notify-send -e -a playerctl "Playerctl" "$NEXT_PLAYER - $STATUS" -i "$ICON"
      else
        NEXT_PLAYER="''${CURRENT_PLAYER:-''${AVAILABLE_PLAYERS[0]}}"
        toggle_player
        notify-send -e -a playerctl "Playerctl" "$NEXT_PLAYER - $STATUS" -i "$ICON"
      fi
    '';
  };
}
