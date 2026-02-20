{
  homes,
  hosts,
  lib,
  ...
}: let
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  position =
    if mymonitor
    then "1280 720"
    else "960 540";
in {
  home.file.".config/qmk/cheatsheet-wrapper.sh" = lib.mkIf hosts.gui.enable {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch movecursor ${position}
      kitty -T crkbd -o cursor="#1a1b26" -o cursor_trail=0 -e ~/.config/qmk/crkbd-cheatsheet.sh
    '';
  };
}
