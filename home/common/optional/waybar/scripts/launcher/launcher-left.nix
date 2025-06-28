{config, ...}: let
  mymonitor = builtins.all (m: m.height == 1440) config.monitors;
  position =
    if mymonitor
    then "1280 720"
    else "960 540";
in {
  home.file.".config/waybar/scripts/launcher/launcher-left.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      hyprctl dispatch movecursor ${position}
      kitty -T fastfetch -o cursor=#1a1b26 -o cursor_trail=0 -e fish -c '
        fastfetch --logo-position right --logo-padding-right 0
        bash -c "read -n 1"'
    '';
  };
}
