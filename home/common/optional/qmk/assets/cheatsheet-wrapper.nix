{config, ...}: let
  mymonitor = builtins.all (m: m.height == 1440) config.monitors;
  position =
    if mymonitor
    then "1280 720"
    else "960 540";
in {
  home.file.".config/qmk/cheatsheet-wrapper.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch movecursor ${position}
      kitty -T crkbd -o cursor="#1a1b26" -o cursor_trail=0 -e ~/.config/qmk/crkbd-cheatsheet.sh
    '';
  };
}
