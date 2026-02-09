{config, ...}: let
  theme =
    if config.spec.theme == "tokyo-night-dark"
    then "tokyo-dark"
    else if config.spec.theme == "catppuccin-mocha"
    then "catppuccin"
    else "palette";
in {
  home.file.".config/hypr/scripts/hyprpaper.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      WALL_DIR="$HOME/Pictures/gowall"
      CACHE_DIR="$HOME/.cache/bosse"
      LOG_FILE="$CACHE_DIR/daily-wallpaper.log"
      DATE=$(date +%Y%m%d)
      OUTPUT_IMG="$CACHE_DIR/hyprpaper.png"

      mkdir -p "$WALL_DIR" "$CACHE_DIR"

      : > "$LOG_FILE"
      exec > >(tee -a "$LOG_FILE") 2>&1
      echo "--- [$(date '+%Y-%m-%d %H:%M:%S')] Script Started ---"

      GATEWAY_IP=$(ip route | grep default | awk '{print $3}' | head -n 1)

      if [[ -n "$GATEWAY_IP" ]]; then
        if ! ping -c 1 -W 1 "$GATEWAY_IP" >/dev/null 2>&1; then
          echo "Local gateway ($GATEWAY_IP) unreachable. Are you connected to Wi-Fi/Ethernet?"
          exit 1
        fi
        echo "Local link to $GATEWAY_IP is up."
      else
        echo "No default gateway found. Network might be down."
        exit 1
      fi

      cd "$WALL_DIR"
      INPUT_WALL=$(find . -maxdepth 1 -type f -name "wall-''${DATE}.*" -print -quit)

      if [[ -z "$INPUT_WALL" ]]; then
        echo "Fetching today's top wallpaper from Reddit..."
        USER_AGENT="User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101 Firefox/100.0"
        REDDIT_LINK="https://www.reddit.com/r/wallpaper/top/.json?limit=5"
        JSON_DATA=$(curl -sH "$USER_AGENT" "$REDDIT_LINK")
        IMG_URL=$(echo "$JSON_DATA" | jq -r '.data.children[] | select(.data.post_hint == "image") | .data.url' | head -n 1)

        if [[ -n "$IMG_URL" && "$IMG_URL" != "null" ]]; then
          EXT="''${IMG_URL##*.}"
          EXT=$(echo "$EXT" | cut -d'?' -f1)
          INPUT_WALL="wall-''${DATE}.''${EXT}"
          curl -sL "$IMG_URL" -o "$INPUT_WALL"
        else
          echo "Error: Could not find a valid image URL on Reddit."
          exit 1
        fi
      else
        echo "Today's wallpaper already exist"
        exit 0
      fi

      MIME_TYPE=$(file --mime-type -b "$INPUT_WALL")
      if [[ "$MIME_TYPE" == image/* ]]; then
        echo "Validation successful: $MIME_TYPE"
      else
        echo "Validation failed: File is $MIME_TYPE. Deleting."
        rm -f "$INPUT_WALL"
        exit 1
      fi

      gowall convert "$INPUT_WALL" -t ${theme} --output "$OUTPUT_IMG"
      cp "$OUTPUT_IMG" "$CACHE_DIR/hyprlock.png"
      echo "Success"
    '';
  };
}
