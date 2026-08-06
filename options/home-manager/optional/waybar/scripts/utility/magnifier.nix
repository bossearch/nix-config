{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/magnifier.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      if hyprctl getoption cursor:zoom_factor | grep -q "float: 1.000000"; then
        hyprctl eval "hl.config({ cursor = { zoom_factor = 2.0 } })"
      else
        hyprctl eval "hl.config({ cursor = { zoom_factor = 1.0 } })"
      fi
    '';
  };
}
