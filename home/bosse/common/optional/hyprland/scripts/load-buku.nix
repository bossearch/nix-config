{
  home.file.".config/hypr/scripts/load-buku.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      trap 'rm -f /tmp/buku_block_*' EXIT

      buku -p --nc | awk '
        function flush_block() {
          if (title && url && block) {
            gsub(/^[ \t]*> /, "", url)
            tmpfile = "/tmp/buku_block_" ++i
            # Strip leading whitespace from all lines
            gsub(/^[ \t]+/, "", block)
            gsub(/\n[ \t]+/, "\n", block)
            print block > tmpfile
            close(tmpfile)
            printf "%s\t%s\t%s\n", title, url, tmpfile
          }
          block = title = url = ""
        }

        /^[0-9]+\./ {
          flush_block()
          block = $0 "\n"
          title = substr($0, index($0, " ") + 1)
          next
        }

        {
          block = block $0 "\n"
          if ($0 ~ /^[ \t]*> / && url == "") {
            url = $0
          }
        }

        END {
          flush_block()
        }
      ' |
      fzf \
        --multi \
        --border=none \
        --delimiter='\t' \
        --with-nth=1 \
        --preview 'cat {3}' \
        --preview-window=up:wrap:5 |
      cut -f2 |
      while read -r url; do
        [ -n "$url" ] && setsid bash -c "xdg-open '$url'" >/dev/null 2>&1 & disown
      done
    '';
  };
}
