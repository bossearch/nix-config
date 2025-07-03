{
  home.file.".config/hypr/scripts/quit.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Get the class of the currently focused window
      focused_class=$(hyprctl activewindow | awk '/class:/ {print $2}')

      # If the class is "Waydroid", stop the Waydroid session
      if [[ "$focused_class" == "Waydroid" ]]; then
        waydroid session stop

      elif [[ "$focused_class" == "mpv" ]]; then
        if ! echo '{ "command": ["quit"] }' | socat - UNIX-CONNECT:/tmp/mpv-socket; then
          pkill mpv
        fi

      elif [[ "$focused_class" == "org.gnome.Nautilus" ]]; then
        nautilus --quit

      else
        hyprctl dispatch killactive
      fi
    '';
  };
}
