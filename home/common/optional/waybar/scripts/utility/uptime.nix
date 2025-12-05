{
  home.file.".config/waybar/scripts/utility/uptime.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      up=$(uptime | sed -E 's/.* up ([^,]+).*/\1/')

      days=0 hours=0 mins=0

      d=$(echo "$up" | grep -oE '[0-9]+ day' | awk '{print $1}')
      [ -n "$d" ] && days=$d

      hm=$(echo "$up" | grep -oE '[0-9]+:[0-9]+')
      if [ -n "$hm" ]; then
        hours=$((10#''${hm%:*}))
        mins=$((10#''${hm#*:}))
      fi

      m=$(echo "$up" | grep -oE '[0-9]+ min' | awk '{print $1}')
      [ -n "$m" ] && mins=$((10#$m))

      parts=""
      [ "$days" -gt 0 ] && parts="$parts $days day$([ "$days" -ne 1 ] && echo s)"
      [ "$hours" -gt 0 ] && parts="$parts $hours hour$([ "$hours" -ne 1 ] && echo s)"
      [ "$mins" -gt 0 ] && parts="$parts $mins minute$([ "$mins" -ne 1 ] && echo s)"

      parts="''${parts#"''${parts%%[! ]*}"}"

      echo "{\"tooltip\": \"Uptime: $parts\"}"
    '';
  };
}
