{config, ...}: {
  home.file.".config/waybar/scripts/screenrecord/stoprec.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      PID=$(pgrep wl-screenrec)
      CACHE_DIR="$HOME/.cache/${config.spec.userName}"

      if [ -n "$PID" ]; then
        kill -INT "$PID"
        pactl unload-module module-combine-sink
        pactl unload-module module-loopback
        if [[ -f $CACHE_DIR/default-sink ]]; then
          pactl set-default-sink "$(cat "$CACHE_DIR/default-sink")"
          rm -rf "$CACHE_DIR/default-sink"
        fi
      fi
    '';
  };
}
