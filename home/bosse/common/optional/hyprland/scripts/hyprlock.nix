{...}: {
  home.file.".config/hypr/scripts/hyprlock.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      SCREENSHOT_PATH="/tmp/hyprlock.png"
      rm "$SCREENSHOT_PATH"
      grim -l 0 -t png "$SCREENSHOT_PATH"

      hyprlock
    '';
  };
}
