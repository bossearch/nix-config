{
  homes,
  lib,
  ...
}: let
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  position =
    if mymonitor
    then "x = 1280, y = 720"
    else "x = 960, y = 540";
in {
  home.file.".config/waybar/scripts/launcher/launcher-right.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch 'hl.dsp.cursor.move({ ${position} })'
      footclient -o "main.font=${homes.nerdfont} Nerd Font:size=24" \
        -o "main.font-bold=${homes.nerdfont} Nerd Font:style=bold:size=24" \
        -o "main.line-height=29" \
        -T bigfzf ~/.config/fzf/extra/drun.sh
    '';
  };
}
