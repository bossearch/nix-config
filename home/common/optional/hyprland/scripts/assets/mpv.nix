{
  home.file.".config/hypr/scripts/assets/mpv.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      MPV_SOCKET="/tmp/mpv-socket"

      # Check if mpv is already running
      if pgrep -x "mpv" >/dev/null; then
        echo '{ "command": ["quit"] }' | socat - UNIX-CONNECT:"$MPV_SOCKET"
      else
        mpv --player-operation-mode=pseudo-gui --input-ipc-server="$MPV_SOCKET"
      fi
    '';
  };
}
