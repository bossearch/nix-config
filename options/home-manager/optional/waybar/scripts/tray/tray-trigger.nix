{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/tray/tray-trigger.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      case "$1" in
        wl-screenrec)
          while pgrep "wl-screenrec" >/dev/null; do
            sleep 1
            pkill -SIGRTMIN+11 waybar
          done
          ;;
        *)
          exit 0
          ;;
      esac
    '';
  };
}
