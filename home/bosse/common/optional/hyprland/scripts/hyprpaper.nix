{
  home.file.".config/hypr/scripts/hyprpaper.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -e

      pushd ~/Pictures/gowall >/dev/null || exit

      log_file="''${HOME}/.cache/bosse/daily-wallpaper.log"
      mkdir -p "$(dirname "$log_file")"
      echo "[daily-wallpaper] $(date): Internet connection check..." >"$log_file"

      if nmcli device status | grep -q '^br0'; then
        for i in {1..60}; do
          state=$(nmcli -t -f GENERAL.STATE device show br0 | awk -F'[: ]' '{print $2}')
          echo "Attempt $i: br0 state is $state" >>"$log_file"
          if [ "$state" = "100" ]; then
            break
          fi
          sleep 1
        done
      else
        echo "br0 not found, falling back to generic internet check..." >>"$log_file"
        sleep 10
        if ! ping -c 1 1.1.1.1 >/dev/null 2>&1; then
          echo "Internet check failed. Aborting." >>"$log_file"
          exit 1
        else
          echo "Internet is reachable." >>"$log_file"
        fi
      fi

      DATE=$(date +%Y%m%d)
      INPUT_WALL=$(find . -maxdepth 1 -type f -name "wall-''${DATE}.*" -printf "%f\n" | head -n 1)
      OUTPUT_DIR="''${HOME}/.cache/bosse"

      if [ ! -f "$INPUT_WALL" ]; then
        curl -s -A "Mozilla/5.0" 'https://www.reddit.com/r/wallpaper/top/.json?limit=5' |
          jq -r '.data.children[] | select(.data.post_hint == "image") | .data.url' |
          head -n 1 |
          xargs -I {} sh -c "ext=\"\''${1##*.}\"; wget -q -O \"wall-\$(date +%Y%m%d).\$ext\" \"\$1\"" _ {};
          echo "Wallpaper downloaded" >>"$log_file"
      fi

      if file wall-"''${DATE}".* | grep -qE 'image|bitmap'; then
        echo "Wallpaper file is valid image." >> "$log_file"
      else
        echo "Invalid wallpaper file. Removing." >> "$log_file"
        rm -f wall-"''${DATE}".*
      fi

      INPUT_WALL=$(find . -maxdepth 1 -type f -name "wall-''${DATE}.*" -printf "%f\n" | head -n 1)
      if [ -f "$INPUT_WALL" ]; then
        gowall convert "$INPUT_WALL" -t palette --output "$OUTPUT_DIR/hyprpaper.png"
        cp "$OUTPUT_DIR/hyprpaper.png" "$OUTPUT_DIR/hyprlock.png"
        echo "Wallpaper converted" >> "$log_file"
      fi

      popd >/dev/null || exit
    '';
  };
}
