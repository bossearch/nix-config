{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/mpv/mpv.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      FILE="$1"
      MPV_SOCKET="/tmp/mpv-socket"

      if pgrep -x "mpv" >/dev/null; then
        echo "{\"command\": [\"loadfile\", \"$1\", \"replace\"]}" | socat - UNIX-CONNECT:"$MPV_SOCKET"
      else
        mpv --player-operation-mode=pseudo-gui --input-default-bindings=no --input-ipc-server="$MPV_SOCKET" ''${1:+ "$1"}
      fi
    '';
  };
}
