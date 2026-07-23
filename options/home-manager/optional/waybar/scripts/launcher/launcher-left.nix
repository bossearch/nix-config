{
  config,
  homes,
  lib,
  ...
}: let
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  position =
    if mymonitor
    then "x = 1280, y = 720"
    else "x = 960, y = 540";
  base01 = "${config.colorScheme.palette.base01}";
  base07 = "${config.colorScheme.palette.base07}";
in {
  home.file.".config/waybar/scripts/launcher/launcher-left.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch 'hl.dsp.cursor.move({ ${position} })'
      footclient -H -T fastfetch -o "colors-dark.cursor=${base07} ${base01}" sh -c '
        sleep 0.1 && fastfetch'
    '';
  };
}
