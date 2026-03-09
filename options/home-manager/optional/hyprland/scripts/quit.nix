{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/quit.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      focused_class=$(hyprctl activewindow -j | jq -r '.class')
      focused_title=$(hyprctl activewindow -j | jq -r '.title')

      if [[ "$focused_class" == "Waydroid" ]]; then
        waydroid session stop

      elif [[ "$focused_class" == "mpv" ]]; then
        if ! echo '{ "command": ["quit"] }' | socat - UNIX-CONNECT:/tmp/mpv-socket; then
          pkill mpv
        fi

      elif [[ "$focused_class" == "org.gnome.Nautilus" ]]; then
        nautilus --quit

      elif [[ "$focused_class" == "steam" ]]; then
        killall steam

      elif [[ "$focused_class" == "steam_app_default" ]] &&
        [[ -z "$focused_title" ||
          "$focused_title" == "Magic Chess: Go Go" ||
          "$focused_title" == "MagicChessGoGo" ]]; then
        pkill -f mcgg

      else
        hyprctl dispatch killactive
      fi
    '';
  };
}
