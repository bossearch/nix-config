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

      if pgrep -x "mpv" >/dev/null; then
        echo "{\"command\": [\"loadfile\", \"$1\", \"replace\"]}" | socat - UNIX-CONNECT:"/tmp/mpv-socket"
      else
        mpv --player-operation-mode=pseudo-gui --input-default-bindings=no ''${1:+ "$1"}
      fi
    '';
  };
}
