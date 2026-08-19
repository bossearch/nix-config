{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/virtualkeyboard.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      if ! pgrep sysboard >/dev/null; then
        hyprctl eval "hl.exec_cmd('sysboard -H 400 -m 8')"
        sleep 0.1
        notify-send -e "Virtual Keyboard" "On" -i keyboard
      else
        notify-send -e 'Virtual Keyboard' 'Off' -i keyboard
        pkill sysboard
      fi
    '';
  };
}
