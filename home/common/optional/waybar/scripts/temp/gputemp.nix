{config, ...}: {
  home.file.".config/waybar/scripts/temp/gputemp.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      TEMP_FILE="$HOME/.cache/${config.spec.userName}/gputemp"

      for i in /sys/class/hwmon/hwmon*/temp1_input; do
        name_file="$(dirname "$i")/name"
        if [[ -f "$name_file" ]]; then
          name=$(<"$name_file")
          if [[ "$name" == "amdgpu" ]]; then
            temp=$(<"$i")
            # Convert millidegree to degree Celsius
            temp_c=$((temp / 1000))
            echo "$temp_c" >>"$TEMP_FILE"
            break
          fi
        fi
      done

      tooltip=$($HOME/.config/waybar/scripts/temp/graph.sh gpu)

      echo "{\"text\": \"$temp_c\", \"tooltip\": \"$tooltip\"}"
    '';
  };
}
