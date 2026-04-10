{
  homes,
  lib,
  ...
}: let
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  position =
    if mymonitor
    then "1280 720"
    else "960 540";
in {
  home.file.".config/waybar/scripts/launcher/launcher-right.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch movecursor ${position}
      footclient -o "main.font=${homes.nerdfont} Nerd Font:size=24" \
        -o "main.font-bold=${homes.nerdfont} Nerd Font:style=bold:size=24" \
        -o "main.line-height=29" \
        -T mousefzf ~/.config/fzf/extra/drun.sh
    '';
  };
}
