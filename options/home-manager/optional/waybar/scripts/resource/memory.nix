{
  homes,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/resource/memory.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      read -r percent used < <(awk '/^MemTotal:/ {t=$2} /^MemAvailable:/ {a=$2} END {
          printf "%d Used:_%.1f_GB_/_Total:_%.1f_GB", (t-a)/t*100, (t-a)/1048576, t/1048576
      }' /proc/meminfo)

      used="''${used//_/ }"

      memhogs=$(ps -e -o rss,args --sort=-rss --no-headers | head -n 10 | awk '
        function to_human(kb) {
          u="KMGT"; i=0; v = kb;
          while (v >= 1024 && i < 3) { v /= 1024; i++; }
          return sprintf("%.1f%sB", v, substr(u, i+1, 1))
        }
        {
          rss = $1
          full_name = $2
          sub(/.*\//, "", full_name)
          if (full_name == "") full_name = $2
          if (NR > 1) printf "\\n";
          printf "%-20s %s", full_name, to_human(rss)
        }
      ')

      tooltip="$used\n\n$memhogs"
      printf '{"text": "%s", "tooltip": "%s"}' "$percent" "$tooltip"
    '';
  };
}
