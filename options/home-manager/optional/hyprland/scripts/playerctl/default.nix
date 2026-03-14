{
  hosts,
  lib,
  mylib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  imports = mylib.autoimport ./.;

  home.file.".config/hypr/scripts/playerctl/playerctl.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      STATE_FILE="$HOME/.cache/bosse/player"
      ICON="media-playback-start"

      mapfile -t AVAILABLE_PLAYERS < <(playerctl -l 2>/dev/null | sort)

      if [ "''${#AVAILABLE_PLAYERS[@]}" -eq 0 ]; then
        notify-send -a playerctl -i "$ICON" "Playerctl" "No media players found"
        exit 0
      fi

      if [ -f "$STATE_FILE" ]; then
        CURRENT_PLAYER=$(cat "$STATE_FILE" | xargs)
      else
        CURRENT_PLAYER="''${AVAILABLE_PLAYERS[0]}"
      fi

      NEXT_PLAYER=""
      for i in "''${!AVAILABLE_PLAYERS[@]}"; do
        if [[ "''${AVAILABLE_PLAYERS[$i]}" == "$CURRENT_PLAYER" ]]; then
          NEXT_INDEX=$(((i + 1) % ''${#AVAILABLE_PLAYERS[@]}))
          NEXT_PLAYER="''${AVAILABLE_PLAYERS[$NEXT_INDEX]}"
          break
        fi
      done

      echo "$NEXT_PLAYER" >"$STATE_FILE"
      notify-send -a playerctl -i "$ICON" "Playerctl" "$NEXT_PLAYER"
    '';
  };
}
