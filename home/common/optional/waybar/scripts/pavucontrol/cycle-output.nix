{
  home.file.".config/waybar/scripts/pavucontrol/cycle-output.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -e

      # Get the current default sink
      CURRENT_SINK=$(pactl get-default-sink)

      # Get a list of all sinks
      mapfile -t SINKS < <(pactl list short sinks | awk '{print $2}' | grep -vE 'wl-screenrec|virtual')

      if [[ ''${#SINKS[@]} -eq 0 ]]; then
          notify-send --urgency=critical "No audio output found!"
          exit 1
      fi

      if [[ ''${#SINKS[@]} -eq 1 ]]; then
          exit 0
      fi

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
