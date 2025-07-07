{config, ...}: {
  home.file.".config/hypr/scripts/hyprlock.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      CACHE_DIR="$HOME/.cache/${config.spec.userName}"
      SCREENSHOT_PATH="$CACHE_DIR/hyprlock.png"
      rm "$SCREENSHOT_PATH"
      grim -l 0 -t png "$SCREENSHOT_PATH"

      hyprlock &
      sleep 5
      cp "$CACHE_DIR/hyprpaper.png" "$CACHE_DIR/hyprlock.png"
    '';
  };
}
