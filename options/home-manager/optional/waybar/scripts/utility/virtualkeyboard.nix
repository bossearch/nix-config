{
  homes,
  lib,
  ...
}: let
  condition =
    if homes.notify == "dunst"
    then ''if ! pgrep sysboard >/dev/null; then''
    else if homes.notify == "swaync"
    then ''if [ "$SWAYNC_TOGGLE_STATE" = "true" ]; then''
    else "";
in {
  home.file.".config/waybar/scripts/utility/virtualkeyboard.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ${condition}
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
