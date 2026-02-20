{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/utility/hyprpicker.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl --batch "\
      keyword decoration:blur:enabled 0;\
      keyword decoration:active_opacity 1;\
      keyword decoration:inactive_opacity 1"

      sleep 0.5

      hyprpicker -a
      trap 'hyprctl reload' EXIT
    '';
  };
}
