{
  home.file.".config/fzf/extra/drun.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Read the app names and Exec commands from the saved txt file
      apps_list=$(cat "$HOME/.cache/$(whoami)/drun.txt")

      # Use fzf to list app names and select multiple
      selected=$(
        echo "$apps_list" | cut -d'|' -f1 | sort |
          fzf -m --layout=default --border=none --bind 'tab:select+backward-kill-word'
      )

      # Run each selected application's Exec command
      while IFS= read -r app; do
        if [ -n "$app" ]; then
          exec_command=$(echo "$apps_list" | grep "^$app|" | cut -d'|' -f2)
          setsid bash -c "$exec_command" >/dev/null 2>&1 & disown
        fi
      done <<< "$selected"

      sleep 0.1
    '';
  };
}
