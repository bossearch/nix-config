{config, ...}: {
  home.file.".config/fzf/extra/drun.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Read the app names and Exec commands from the saved txt file
      APPS_LIST=$(cat "$HOME/.cache/${config.spec.userName}/drun.txt")

      # Use fzf to list app names and select multiple
      SELECTED=$(
        echo "$APPS_LIST" | cut -d'|' -f1 | sort |
          fzf -m --layout=default --border=none --bind 'tab:select+backward-kill-word'
      )

      # Run each selected application's Exec command
      while IFS= read -r APP; do
        if [ -n "$APP" ]; then
          EXEC_COMMAND=$(echo "$APPS_LIST" | grep "^$APP|" | cut -d'|' -f2)
          # read -r -a cmd_array <<<"$EXEC_COMMAND"
          # setsid --fork "''${cmd_array[@]}" >/dev/null 2>&1 </dev/null
          setsid --fork bash -c "$EXEC_COMMAND" >/dev/null 2>&1 </dev/null
        fi
      done <<<"$SELECTED"

      sleep 0.1
    '';
  };
}
