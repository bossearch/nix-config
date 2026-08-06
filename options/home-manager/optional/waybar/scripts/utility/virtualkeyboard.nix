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
        setsid --fork bash -c "sysboard -H 400 -m 8" >/dev/null 2>&1 </dev/null
        sleep 0.1
        notify-send -e "Virtual Keyboard" "On" -i keyboard
        pkill -RTMIN sysboard
      else
        notify-send -e 'Virtual Keyboard' 'Off' -i keyboard
        pkill sysboard
      fi
    '';
  };
}
