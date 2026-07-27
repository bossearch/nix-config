{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/hyprpicker.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      hyprctl eval "require('lib.util').toggle_opacity('enable')"

      sleep 0.5
      hyprpicker -a

      hyprctl eval "require('lib.util').toggle_opacity('disable')"
    '';
  };
}
