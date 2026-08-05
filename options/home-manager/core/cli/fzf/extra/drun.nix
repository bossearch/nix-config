{hosts, ...}: {
  home.file.".config/fzf/extra/drun.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      APPS_LIST=$(cat "$HOME/.cache/${hosts.username}/drun.txt")

      SELECTED=$(
        echo "$APPS_LIST" | cut -d'|' -f1 | sort |
          fzf -m --layout=default --border=none --bind 'tab:select+backward-kill-word'
      )

      while IFS= read -r APP; do
        if [ -n "$APP" ]; then
          EXEC_COMMAND=$(echo "$APPS_LIST" | grep "^$APP|" | cut -d'|' -f2)
          systemd-run --user --no-block bash -c "$EXEC_COMMAND" >/dev/null 2>&1
        fi
      done <<<"$SELECTED"

      sleep 0.1
    '';
  };
}
