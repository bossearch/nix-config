{...}: {
  home.file.".config/hypr/scripts/hyprpaper.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      pushd ~/Pictures/gowall >/dev/null || exit

      DATE=$(date +%Y%m%d)

      INPUT_WALL=$(find /home/bosse/Pictures/gowall -maxdepth 1 -type f -name "wall-''\${DATE}.*" -printf "%f\n" | head -n 1)
      OUTPUT_WALL="/tmp/hyprpaper.png"
      THEME="tokyo-dark"
      LOG_FILE="$HOME/hyprpaper.log"

      if [ -f "$LOG_FILE" ]; then
        rm "$LOG_FILE"
        echo "$DATE" >> "$LOG_FILE"
      fi

      if [ -f "$OUTPUT_WALL" ]; then
        rm /tmp/{hyprlock.png,hyprpaper.png}
      fi

      if [ ! -f "$INPUT_WALL" ]; then
        echo y | gowall -w
        echo "downloaded" >> "$LOG_FILE"
      fi

      TODAY_WALL=$(find /home/bosse/Pictures/gowall -maxdepth 1 -type f -name "wall-''\${DATE}-*" -printf "%f\n" | head -n 1)
      # Extract components using regex
      if [[ "$TODAY_WALL" =~ wall-([0-9]{8})-[0-9]{6}\.([a-zA-Z0-9]+)$ ]]; then
        date_part="''\${BASH_REMATCH[1]}"
        ext="''\${BASH_REMATCH[2]}"
        dir=$(dirname "$TODAY_WALL")
        RENAMED_WALL="$dir/wall-''\${date_part}.''\${ext}"
        mv "$TODAY_WALL" "$RENAMED_WALL"
        echo "renamed" >> "$LOG_FILE"
      fi

      INPUT_WALL=$(find /home/bosse/Pictures/gowall -maxdepth 1 -type f -name "wall-''\${DATE}.*" -printf "%f\n" | head -n 1)
      if [ ! -f "$OUTPUT_WALL" ]; then
        gowall convert "$INPUT_WALL" -t "$THEME" --output "$OUTPUT_WALL"
        cp "$OUTPUT_WALL" /tmp/hyprlock.png
        echo "converted" >> "$LOG_FILE"
      fi

      popd >/dev/null || exit

      if ! pgrep -f "Hyprland" > /dev/null; then
        Hyprland
        echo "applied" >> "$LOG_FILE"
      fi
    '';
  };
}
