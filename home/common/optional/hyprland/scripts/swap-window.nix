{config, ...}: {
  home.file.".config/hypr/scripts/swap-window.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      SWAP_SPECIAL_FILE="$HOME/.cache/${config.spec.userName}/swap-special"
      SWAP_NORMAL_FILE="$HOME/.cache/${config.spec.userName}/swap-normal"
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
        hyprctl dispatch swapnext
        exit 0
      fi

      if [[ "$CURRENT_WS" == special:* ]]; then
        WINDOWS=$(
          hyprctl clients -j | jq -c --arg ws "$CURRENT_WS" '
        .[] | select((.workspace? and .workspace.name == $ws) or (.workspace? | not))'
        )

        if [[ -n "$IS_FLOATING" && ! -f "$SWAP_SPECIAL_FILE" ]]; then
          echo "$WINDOWS" | while read -r WIN; do
            ADDR=$(echo "$WIN" | jq -r '.address')
            X=$(echo "$WIN" | jq -r '.at[0]')
            Y=$(echo "$WIN" | jq -r '.at[1]')
            W=$(echo "$WIN" | jq -r '.size[0]')
            H=$(echo "$WIN" | jq -r '.size[1]')

            FLOATED_WINDOW=$(echo "$WIN" | jq -r '.floating')
            if [ "$FLOATED_WINDOW" = "true" ]; then
              continue
            fi

            hyprctl keyword animations:enabled false
            hyprctl dispatch togglefloating "address:$ADDR"
            hyprctl dispatch movewindowpixel "exact $X $Y,address:$ADDR"
            hyprctl dispatch resizewindowpixel "exact $W $H,address:$ADDR"
            hyprctl keyword animations:enabled true
            echo "$ADDR" >>"$SWAP_SPECIAL_FILE"
          done

          hyprctl --batch -q "dispatch focuswindow address:$IS_FLOATING; dispatch alterzorder bottom"

        else
          xargs -a "$SWAP_SPECIAL_FILE" -I{} hyprctl dispatch togglefloating "address:{}"
          rm -f "$SWAP_SPECIAL_FILE"
        fi

      else
        HIDDEN_WINDOW=$(echo "$CLIENTS" | jq -r ".[] | select(.workspace.name==\"special:hidden\" and .floating) | .address" | tail -n 1)

        if [[ ! -f "$SWAP_NORMAL_FILE" && "$IS_HIDDEN" -eq 0 ]]; then
          echo "$CURRENT_WS" >"$SWAP_NORMAL_FILE"
        elif [[ ! -f "$SWAP_NORMAL_FILE" && "$IS_HIDDEN" -gt 0 ]]; then
          echo "$CURRENT_WS" >"$SWAP_NORMAL_FILE"
          LAST_WS=$(cat "$SWAP_NORMAL_FILE")
          rm -f "$SWAP_NORMAL_FILE"
        else
          LAST_WS=$(cat "$SWAP_NORMAL_FILE")
          rm -f "$SWAP_NORMAL_FILE"
        fi

        if [ -n "$IS_FLOATING" ]; then
          hyprctl keyword animations:enabled false
          hyprctl dispatch focuswindow "address:$IS_FLOATING"
          hyprctl dispatch movetoworkspacesilent "special:hidden"
          hyprctl keyword animations:enabled true
          exit 0
        fi

        if [ "$IS_HIDDEN" -gt 0 ]; then
          hyprctl dispatch focuswindow "address:$HIDDEN_WINDOW"
          hyprctl dispatch movetoworkspace "$LAST_WS"
          hyprctl dispatch focuswindow "address:$HIDDEN_WINDOW"
          exit 0
        fi
      fi
    '';
  };
}
