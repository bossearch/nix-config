{
  home.file.".config/fzf/extra/run.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # List all executables from PATH
      IFS=':' read -r -a path_dirs <<< "$PATH"
      EXECUTABLES=$(find -L "''${path_dirs[@]}" -maxdepth 1 -type f -executable 2>/dev/null \
        | awk -F'/' '{print $NF}' | sort -u)

      # Use fzf to select multiple commands
      SELECTED=$(echo "$EXECUTABLES" | fzf -m --layout=default --border=none --bind 'tab:select+backward-kill-word')

      # Process each selected command
      while IFS= read -r COMMAND; do
        if [ -n "$COMMAND" ]; then
          # Run the selected command

          setsid bash -c "$COMMAND" >/dev/null 2>&1 & disown
          # echo "$command" | xargs -r -I {} bash -c 'nohup {} >/dev/null 2>&1 & disown'
        fi
      done <<< "$SELECTED"

      sleep 0.1
    '';
  };
}
