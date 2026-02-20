{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/assets/mpv.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      FILE="$1"
      MPV_SOCKET="/tmp/mpv-socket"

      # Check if mpv is already running
      if pgrep -x "mpv" >/dev/null; then
        echo '{ "command": ["quit"] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"
      else
        mpv --player-operation-mode=pseudo-gui --input-ipc-server="$MPV_SOCKET" ''${1:+ "$1"}
      fi
    '';
  };
}
