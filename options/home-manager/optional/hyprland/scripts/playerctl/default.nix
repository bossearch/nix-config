{
  homes,
  hosts,
  lib,
  mylib,
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
  imports = mylib.autoimport ./.;

  home.file.".config/hypr/scripts/playerctl/playerctl.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      PLAYER_FILE="$HOME/.cache/${hosts.username}/player"
      mapfile -t AVAILABLE_PLAYERS < <(playerctl -l 2>/dev/null)

      if [ "''${#AVAILABLE_PLAYERS[@]}" -eq 0 ]; then
        notify-send -e -a playerctl "Playerctl" "No media players found" -i dialog-warning
        exit 0
      fi

      if [ -f "$PLAYER_FILE" ]; then
        CURRENT_PLAYER=$(tr -d '\n' <"$PLAYER_FILE" | xargs)
      fi

      if [[ -z "$CURRENT_PLAYER" ]] || [[ ! " ''${AVAILABLE_PLAYERS[*]} " =~ $CURRENT_PLAYER ]]; then
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

      NEXT_PLAYER="''${NEXT_PLAYER:-''${AVAILABLE_PLAYERS[0]}}"
      echo -n "$NEXT_PLAYER" >"$PLAYER_FILE"

      STATUS=$(playerctl -p "$NEXT_PLAYER" status 2>/dev/null)
      if [ "$STATUS" == "Playing" ]; then
        ICON="media-playback-start"
      else
        ICON="media-playback-pause"
      fi

      ${close}
      notify-send -e -a playerctl "$NEXT_PLAYER" "$STATUS" -i "$ICON"
    '';
  };
}
