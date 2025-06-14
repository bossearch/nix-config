{
  home.file.".config/hypr/scripts/hyprpaper.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      pushd ~/Pictures/gowall >/dev/null || exit

      DATE=$(date +%Y%m%d)

      INPUT_WALL=$(find . -maxdepth 1 -type f -name "wall-''${DATE}.*" -printf "%f\n" | head -n 1)
      OUTPUT_WALL="/tmp/hyprpaper.png"

      if [ -f "$INPUT_WALL" ]; then
        rm -f /tmp/{hyprlock.png,hyprpaper.png}
        gowall convert "$INPUT_WALL" -t palette --output "$OUTPUT_WALL"
        cp "$OUTPUT_WALL" /tmp/hyprlock.png
      fi

      popd >/dev/null || exit
      hyprpaper >/dev/null 2>&1 &
      hyprlock >/dev/null 2>&1 &
    '';
  };
}
