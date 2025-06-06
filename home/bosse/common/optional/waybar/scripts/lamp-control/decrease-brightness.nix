{
  home.file.".config/waybar/scripts/lamp-control/decrease-brightness.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # IP address of the lamp
      lamp_ip="192.168.18.14"
      port=38899

      # Get current dimming level using Python script
      current_dimming=$(python3 ~/.config/waybar/scripts/lamp-control/get-brightness.py)

      # Print raw output for debugging
      echo "Raw output from Python script: $current_dimming"

      # Extract numeric value from output
      # Remove any non-numeric characters from the beginning and end
      # current_dimming=$(echo "$current_dimming" | grep -oP '(?<="dimming":)[0-9]+')

      # Check if current_dimming is valid
      if ! [[ "$current_dimming" =~ ^[0-9]+$ ]]; then
        echo "Failed to get current dimming level. Raw output: $current_dimming"
        exit 1
      fi

      # Calculate new dimming level
      new_dimming=$((current_dimming - 10))
      # Ensure new dimming level does not go below 0
      if [ "$new_dimming" -lt 10 ]; then
        new_dimming=10
      fi

      # Send the new dimming level to the lamp
      echo "Setting dimming level to $new_dimming" # Debugging info
      echo -n "{\"method\":\"setPilot\",\"params\":{\"dimming\":$new_dimming}}" | socat - UDP:$lamp_ip:$port
    '';
  };
}
