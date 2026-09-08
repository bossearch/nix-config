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
  retroarch =
    if homes.game.retroarch
    then ''
      cp "$OUTPUT_IMG" "$CACHE_DIR/retroarch.png"
    ''
    else "";
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

      ${retroarch}

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
        echo "Fetching today's top wallpaper via RSS proxy..."

        PROXY_URL="https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.reddit.com%2Fr%2Fwallpaper%2Ftop%2F.rss%3Ft%3Dday"
        RAW_FEED=$(curl -sL "$PROXY_URL")

        IMG_URL=$(echo "$RAW_FEED" | grep -oE 'https://i\.redd\.it/[^"&< ]+\.(jpg|png|jpeg)' | head -n 1 || true)

        if [[ -n "$IMG_URL" ]]; then
          EXT="''${IMG_URL##*.}"
          EXT=$(echo "$EXT" | cut -d'?' -f1 | tr -d '[:space:]')
          INPUT_WALL="wall-''${DATE}.''${EXT}"
          curl -sL "$IMG_URL" -o "$INPUT_WALL"
          echo "Wallpaper downloaded: $IMG_URL"
        else
          echo "Error: Could not extract wallpaper URL from proxy response."
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
