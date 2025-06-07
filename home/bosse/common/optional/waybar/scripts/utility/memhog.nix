{
  home.file.".config/waybar/scripts/utility/memhog.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      used=$(free | awk '/^Mem:/ {print $3 * 1024}' | numfmt --to=iec-i --suffix=B --format="%.1f")
      memhogs=$(
        ps axch -o cmd,rss --sort=-rss | head -n 10 | while IFS= read -r line; do
          cmd=$(echo "$line" | sed 's/\s\+[0-9]\+$//' | cut -c1-20)  # Limit command length
          rss=$(echo "$line" | awk '{print $NF}')

          if [[ -n "$rss" && "$rss" =~ ^[0-9]+$ ]]; then
            human_readable=$(numfmt --to=iec-i --suffix=B <<< "$((rss * 1024))")
            printf "%-16s %s\n" "$cmd" "$human_readable"
          fi
        done
      )

      # Escape quotes and newlines
      memhogsjson=$(echo "$memhogs" | sed 's/"/\\"/g' | awk '{printf "%s\\n", $0}' | sed '$s/\\n$//')

      echo "{\"text\": \"$used\", \"tooltip\": \"$memhogsjson\"}"
    '';
  };
}
