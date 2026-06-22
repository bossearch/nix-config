{
  homes,
  hosts,
  lib,
  ...
}: let
  theme =
    if hosts.theme == "tokyo-night-dark"
    then "tokyo-dark"
    else if hosts.theme == "catppuccin-mocha"
    then "catppuccin"
    else "palette";
in {
  home.file.".config/gowall/daily-wallpaper.sh" = lib.mkIf homes.gowall {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      WALL_DIR="$HOME/Pictures/gowall"
      CACHE_DIR="$HOME/.cache/${hosts.username}"
      LOG_FILE="$CACHE_DIR/daily-wallpaper.log"
      DATE=$(date +%Y%m%d)
      OUTPUT_IMG="$CACHE_DIR/hyprpaper.png"
      sleep 10

      : >"$LOG_FILE"
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
        echo "Fetching today's top wallpaper from Reddit via RSS..."
        USER_AGENT="Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/119.0"
        RSS_LINK="https://old.reddit.com/r/wallpaper/top/.rss?t=day"
        RAW_FEED=$(curl -sL -A "$USER_AGENT" "$RSS_LINK")
        IMG_URL=$(echo "$RAW_FEED" | grep -oE 'href=(&quot;|")https://i.redd.it/[^&" ]+\.(jpg|png|jpeg)' | head -n 1 | sed -E 's/href=(&quot;|")//' || true)

        if [[ -n "$IMG_URL" && "$IMG_URL" != "null" ]]; then
          EXT="''${IMG_URL##*.}"
          EXT=$(echo "$EXT" | cut -d'?' -f1 | tr -d '[:space:]')
          INPUT_WALL="wall-''${DATE}.''${EXT}"
          curl -sL -A "$USER_AGENT" "$IMG_URL" -o "$INPUT_WALL"
          echo "Wallpaper downloaded: $IMG_URL"
        else
          echo "Error: Could not extract a valid image URL from the Reddit RSS feed."
          exit 1
        fi
      else
        echo "Today's wallpaper already exists."
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
