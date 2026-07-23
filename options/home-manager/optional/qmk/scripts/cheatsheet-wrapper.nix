{
  config,
  homes,
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.udevqmk;
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  position =
    if mymonitor
    then "x = 1280, y = 720"
    else "x = 960, y = 540";
  base01 = "${config.colorScheme.palette.base01}";
  base07 = "${config.colorScheme.palette.base07}";
in {
  home.file.".config/qmk/cheatsheet-wrapper.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch 'hl.dsp.cursor.move({ ${position} })'
      footclient -o "colors-dark.cursor=${base07} ${base01}" -T crkbd ~/.config/qmk/crkbd-cheatsheet.sh
    '';
  };
}
