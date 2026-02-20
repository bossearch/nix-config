{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/hyprlock.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      CACHE_DIR="$HOME/.cache/${hosts.username}"
      SCREENSHOT_PATH="$CACHE_DIR/hyprlock.png"
      rm "$SCREENSHOT_PATH"
      grim -l 0 -t png "$SCREENSHOT_PATH"

      if pgrep -x senior-agent >/dev/null; then
        pkill -x senior-agent
      fi

      hyprlock &
      sleep 5
      cp "$CACHE_DIR/hyprpaper.png" "$CACHE_DIR/hyprlock.png"
    '';
  };
}
