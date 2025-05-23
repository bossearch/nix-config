{...}: {
  home.file.".config/waybar/scripts/pavucontrol/cycle-output.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Get the current default sink
      CURRENT_SINK=$(pactl info | grep "Default Sink" | cut -d ' ' -f 3)

      # Get a list of all sinks
      SINKS=($(pactl list sinks short | awk '{print $2}'))

      # Find the index of the current sink
      for i in "''${!SINKS[@]}"; do
          if [[ "''${SINKS[$i]}" == "$CURRENT_SINK" ]]; then
              CURRENT_INDEX=$i
              break
          fi
      done

      # Calculate the next sink index (wrap around if at the end of the list)
      NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ''${#SINKS[@]} ))

      # Set the next sink as the default
      pactl set-default-sink "''${SINKS[$NEXT_INDEX]}"

      # Optional: Restart the status bar or any other application that needs to be notified
      sleep 0.1
      pkill -SIGRTMIN+13 waybar
    '';
  };
}
