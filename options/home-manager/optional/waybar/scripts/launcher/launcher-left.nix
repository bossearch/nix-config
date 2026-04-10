{
  config,
  homes,
  lib,
  ...
}: let
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  position =
    if mymonitor
    then "1280 720"
    else "960 540";
  base01 = "${config.colorScheme.palette.base01}";
  base07 = "${config.colorScheme.palette.base07}";
in {
  home.file.".config/waybar/scripts/launcher/launcher-left.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch movecursor ${position}
      footclient -H -T fastfetch -o "colors-dark.cursor=${base07} ${base01}" bash -c '
        sleep 0.1 && fastfetch --logo-position right --logo-padding-right 0 --logo-padding-top 1'
    '';
  };
}
