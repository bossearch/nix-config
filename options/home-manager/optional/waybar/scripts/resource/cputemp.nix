{
  homes,
  hosts,
  lib,
  ...
}: let
  enabled = homes.waybar && hosts.hostname == "silvia";
in {
  home.file.".config/waybar/scripts/resource/cputemp.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      for i in /sys/class/hwmon/hwmon*/temp3_input; do
        if [[ -f "''${i%/*}/name" ]] && [[ $(<"''${i%/*}/name") == "k10temp" ]]; then
          temp=$(<"$i")
          temp_c=$((temp / 1000))
          break
        fi
      done

      echo "{\"text\": \"$temp_c\"}"
    '';
  };
}
