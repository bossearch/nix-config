{config, ...}: {
  home.file.".config/hypr/scripts/assets/tty.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      SESSION_FILE="$HOME/.cache/${config.spec.userName}/session-name"
      SOCKET=''${TMUX:+$(echo "$TMUX" | cut -d',' -f1)}
      SOCKET=''${SOCKET:-''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/tmux-$(id -u)/default}

      mkdir -p "$(dirname "$SOCKET")"

      # Check if tmux is installed
      if command -v tmux &>/dev/null; then
        TERM_TITLE=$(hyprctl activewindow | awk -F': ' '/title: / {print $2}')
        # Check if the title is "magic"
        if [ "$TERM_TITLE" = "scratchpad" ]; then
          # Do nothing explicitly
          :
        else
          if ! tmux -S "$SOCKET" has-session &>/dev/null; then
            # Ask for a session name
            SESSION_NAME=$(zenity --entry --title="Welcome back, ${config.spec.userName}@${config.spec.hostName}" --text="Enter tmux session name:" 2>/dev/null)

            if [ -z "$SESSION_NAME" ] && [ -f "$SESSION_FILE" ]; then
              SESSION_NAME=$(cat "$SESSION_FILE")
            else
              SESSION_NAME=''\${SESSION_NAME:-default}
            fi

            echo "$SESSION_NAME" >"$SESSION_FILE"
            # Start a new tmux session with the given name
            tmux -S "$SOCKET" new-session -d -s "$SESSION_NAME"
            exec tmux -S "$SOCKET" attach-session -t "$SESSION_NAME"
          else
            if ! tmux -S "$SOCKET" list-sessions -F '#{session_attached}' | grep -q '^1$'; then
              exec tmux -S "$SOCKET" attach-session -t "$SESSION_NAME"
            fi
          fi
        fi
      else
        :
      fi
    '';
  };
}
