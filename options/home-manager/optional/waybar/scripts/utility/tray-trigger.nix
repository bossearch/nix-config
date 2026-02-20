{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/tray-trigger.sh" = lib.mkIf homes.waybar {
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
        xdm)
          pkill -SIGRTMIN+15 waybar
          ;;
        *)
          exit 0
          ;;
      esac
    '';
  };
}
