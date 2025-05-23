{...}: {
  home.file.".config/waybar/scripts/pavucontrol/cycle-input.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Get the current default source (microphone)
      CURRENT_SOURCE=$(pactl info | grep "Default Source" | cut -d ' ' -f 3)

      # Get a list of all input sources (microphones)
      SOURCES=($(pactl list sources short | awk '/input/ {print $2}'))

      # Find the index of the current source
      for i in "''${!SOURCES[@]}"; do
          if [[ "''${SOURCES[$i]}" == "$CURRENT_SOURCE" ]]; then
              CURRENT_INDEX=$i
              break
          fi
      done

      # Calculate the next source index (wrap around if at the end of the list)
      NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ''${#SOURCES[@]} ))

      # Set the next source as the default
      pactl set-default-source "''${SOURCES[$NEXT_INDEX]}"

      # Optional: Restart the status bar or any other application that needs to be notified
      sleep 0.1
      pkill -SIGRTMIN+14 waybar
    '';
  };
}
