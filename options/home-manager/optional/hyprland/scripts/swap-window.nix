{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/swap-window.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      SWAP_FILE="$HOME/.cache/${hosts.username}/swap-window"
      CLIENTS=$(hyprctl clients -j)
      ACTIVE_WINDOW=$(hyprctl activewindow -j)
      CURRENT_WS=$(echo "$ACTIVE_WINDOW" | jq -r '.workspace.name')
      IS_HIDDEN=$(echo "$CLIENTS" | jq "map(select(.workspace.name==\"special:hidden\" and .floating)) | length")

      IS_FLOATING=$(echo "$CLIENTS" | jq -r --arg ws "$(echo "$ACTIVE_WINDOW" | jq -r '.workspace.name')" '
          .[]
          | select((.workspace? and .workspace.name == $ws) or (.workspace? | not))
          | select(.floating == true)
          | .address')

      if [[ -z "$IS_FLOATING" && "$IS_HIDDEN" -eq 0 ]]; then
        hyprctl eval "require('lib.util').swap_window('is_normal')"
        exit 0
      fi

      HIDDEN_WINDOW=$(echo "$CLIENTS" | jq -r ".[] | select(.workspace.name==\"special:hidden\" and .floating) | .address" | tail -n 1)

      if [[ ! -f "$SWAP_FILE" && "$IS_HIDDEN" -eq 0 ]]; then
        echo "$CURRENT_WS" >"$SWAP_FILE"
      elif [[ ! -f "$SWAP_FILE" && "$IS_HIDDEN" -gt 0 ]]; then
        echo "$CURRENT_WS" >"$SWAP_FILE"
        LAST_WS=$(cat "$SWAP_FILE")
        notify-send "$LAST_WS"
        rm -f "$SWAP_FILE"
      else
        LAST_WS=$(cat "$SWAP_FILE")
        rm -f "$SWAP_FILE"
      fi

      if [[ -n "$IS_FLOATING" ]]; then
        hyprctl eval "require('lib.util').swap_window('is_floating', '$IS_FLOATING')"
        exit 0
      fi

      if [ "$IS_HIDDEN" -gt 0 ]; then
        hyprctl eval "require('lib.util').swap_window('is_hidden', '$HIDDEN_WINDOW', $LAST_WS)"
        echo "$HIDDEN_WINDOW" | wl-copy
        exit 0
      fi
    '';
  };
}
