{
  home.file.".config/waybar/scripts/utility/virtualkeyboard.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Toggle the visibility of sysboard
      if pgrep sysboard >/dev/null; then
        dunstctl close
        notify-send "Virtual Keyboard" "Hold" -i keyboard
        pkill -10 sysboard
      else
        notify-send "Virtual Keyboard" "On" -i keyboard
        sysboard -H 0.4 -m 8
      fi
    '';
  };
}
