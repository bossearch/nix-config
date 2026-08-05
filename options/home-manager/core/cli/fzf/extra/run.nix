{
  home.file.".config/fzf/extra/run.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      IFS=':' read -r -a path_dirs <<< "$PATH"
      EXECUTABLES=$(find -L "''${path_dirs[@]}" -maxdepth 1 -type f -executable 2>/dev/null \
        | awk -F'/' '{print $NF}' | sort -u)

      SELECTED=$(echo "$EXECUTABLES" | fzf -m --layout=default --border=none --bind 'tab:select+backward-kill-word')

      while IFS= read -r COMMAND; do
        if [ -n "$COMMAND" ]; then
          systemd-run --user --no-block bash -c "$COMMAND" >/dev/null 2>&1
        fi
      done <<< "$SELECTED"

      sleep 0.1
    '';
  };
}
