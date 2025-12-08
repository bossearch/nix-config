{config, ...}: {
  home.file.".config/waybar/scripts/dunst/history.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      VOLUME_FILE="$HOME/.cache/${config.spec.userName}/volume"

      DISPLAYED=$(dunstctl count | awk '/Currently displayed:/ {print $3}')
      HIST_COUNT=$(dunstctl count | awk '/History:/ {print $2}')

      clear_hist() {
        dunstctl history |
          jq '.data[0][0:5][]? | .id.data' |
          xargs -r -I {} dunstctl history-rm {}
      }

      if [[ "$HIST_COUNT" -eq 0 && "$DISPLAYED" -eq 0 ]]; then
        notify-send -u critical -t 1000 "Notification history is empty"
        while true; do
          DISPLAYED=$(dunstctl count | awk '/Currently displayed:/ {print $3}')
          if [ "$DISPLAYED" -eq 0 ]; then
            break
          fi
          sleep 0.2
        done
        dunstctl history-clear
        exit 0
      fi

      if [ "$DISPLAYED" -gt 0 ]; then
        dunstctl close-all
        clear_hist
      else
        cp "$VOLUME_FILE" "$VOLUME_FILE".bak
        echo "0" >"$VOLUME_FILE"

        seq 5 | xargs -I _ dunstctl history-pop

        rm -f "$VOLUME_FILE"
        mv "$VOLUME_FILE".bak "$VOLUME_FILE"
      fi
    '';
  };
}
