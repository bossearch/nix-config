{config, ...}: let
  mymonitor = builtins.all (m: m.height == 1440) config.monitors;
  position =
    if mymonitor
    then "1280 720"
    else "960 540";
in {
  home.file.".config/waybar/scripts/launcher/launcher-right.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch movecursor ${position}
      kitty -T mousefzf -o font_size=24 -o cursor_trail=0 fish -c "~/.config/fzf/extra/drun.sh"
    '';
  };
}
