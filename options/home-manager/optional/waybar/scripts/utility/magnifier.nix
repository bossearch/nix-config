{
  homes,
  lib,
  ...
}: let
  condition =
    if homes.notify == "dunst"
    then ''if hyprctl getoption cursor:zoom_factor | grep -q "float: 1.000000"; then''
    else if homes.notify == "swaync"
    then ''if [ "$SWAYNC_TOGGLE_STATE" = "true" ]; then''
    else "";
in {
  home.file.".config/waybar/scripts/utility/magnifier.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ${condition}
        hyprctl eval "hl.config({ cursor = { zoom_factor = 2.0 } })"
      else
        hyprctl eval "hl.config({ cursor = { zoom_factor = 1.0 } })"
      fi
    '';
  };
}
