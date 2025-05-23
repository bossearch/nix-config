{...}: {
  home.file.".config/hypr/scripts/quit.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Get the class of the currently focused window
      focused_class=$(hyprctl activewindow | awk '/class:/ {print $2}')

      # If the class is "Waydroid", stop the Waydroid session
      if [[ "$focused_class" == "Waydroid" ]]; then
        pkexec ~/.config/hypr/scripts/assets/waydroid-quit.sh
      elif [[ "$focused_class" == "mpv" ]]; then
        echo '{ "command": ["quit"] }' | socat - UNIX-CONNECT:/tmp/mpv-socket
      else
        hyprctl dispatch killactive
      fi
    '';
  };
}
