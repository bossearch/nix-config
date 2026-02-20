{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  imports = [
    ./player-seek.nix
    ./player-skip.nix
    ./player-toggle.nix
  ];
  home.file.".config/hypr/scripts/playerctl/playerctl.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Temp file to store current player
      STATE_FILE="$HOME/.cache/${hosts.username}/player"

      # Get currently available players
      AVAILABLE_PLAYERS=($(playerctl -l 2>/dev/null | sort))

      # Handle no players
      if [ "''${#AVAILABLE_PLAYERS[@]}" -eq 0 ]; then
          notify-send -a playerctl -i "$ICON" "Playerctl" "No media players found"
          exit 0
      fi

      # Handle single player
      if [ "''${#AVAILABLE_PLAYERS[@]}" -lt 2 ]; then
          echo "''${AVAILABLE_PLAYERS[0]}" > "$STATE_FILE"
          notify-send -a playerctl -i "$ICON" "Playerctl" "''${AVAILABLE_PLAYERS[0]}"
          exit 0
      fi

      # Read current player or default to the first one
      if [ -f "$STATE_FILE" ]; then
          CURRENT_PLAYER=$(cat "$STATE_FILE")
      else
          CURRENT_PLAYER="''${AVAILABLE_PLAYERS[0]}"
      fi

      # Rotate to next available player
      NEXT_PLAYER=""
      for (( i=0; i<''${#AVAILABLE_PLAYERS[@]}; i++ )); do
          if [[ "''${AVAILABLE_PLAYERS[$i]}" == "$CURRENT_PLAYER" ]]; then
              NEXT_INDEX=$(( (i + 1) % ''${#AVAILABLE_PLAYERS[@]} ))
              NEXT_PLAYER="''${AVAILABLE_PLAYERS[$NEXT_INDEX]}"
              break
          fi
      done

      # Save and report
      echo "$NEXT_PLAYER" > "$STATE_FILE"
      notify-send -a playerctl -i "$ICON" "Playerctl" "$NEXT_PLAYER"
    '';
  };
}
