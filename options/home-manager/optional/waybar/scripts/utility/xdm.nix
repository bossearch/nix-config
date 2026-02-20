{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/xdm.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      if hyprctl clients -j | jq -e '.[] | select(.class=="Xdm-app")' >/dev/null; then
        hyprctl dispatch closewindow class:Xdm-app
      else
        xdm
      fi
    '';
  };
}
