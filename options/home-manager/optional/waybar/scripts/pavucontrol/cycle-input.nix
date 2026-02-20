{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/pavucontrol/cycle-input.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -e

      # Get the current default source (microphone)
      CURRENT_SOURCE=$(pactl get-default-source)

      # Get a list of all input sources (microphones)
      mapfile -t SOURCES < <(pactl list short sources | awk '/alsa_input/ {print $2}')

      if [[ ''${#SOURCES[@]} -eq 0 ]]; then
          notify-send --urgency=critical "No audio input found!"
          exit 1
      fi

      if [[ ''${#SOURCES[@]} -eq 1 ]]; then
          exit 0
      fi

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
