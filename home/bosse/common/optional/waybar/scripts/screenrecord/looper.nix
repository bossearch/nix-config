{
  home.file.".config/waybar/scripts/screenrecord/looper.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      while pgrep wl-screenrec >/dev/null; do
        sleep 1
        pkill -SIGRTMIN+11 waybar
      done
    '';
  };
}
