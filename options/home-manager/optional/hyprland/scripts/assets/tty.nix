{
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  home.file.".config/hypr/scripts/assets/tty.sh" = lib.mkIf enabled {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      SESSION_FILE="$HOME/.cache/${hosts.username}/session-name"
      SOCKET="$XDG_RUNTIME_DIR/tmux-$(id -u)/default"

      mkdir -p "$(dirname "$SOCKET")"
      chmod 700 "$(dirname "$SOCKET")"

      if [ ! -f /tmp/nvim-startup.log ]; then
        nvim --headless +q --startuptime /tmp/nvim-startup.log
      fi

      if command -v tmux &>/dev/null; then
        TERM_TITLE=$(hyprctl activewindow | awk -F': ' '/title: / {print $2}')
        if [ "$TERM_TITLE" = "scratchpad" ]; then
          :
        else
          if tmux -S "$SOCKET" has-session &>/dev/null; then
            if ! tmux -S "$SOCKET" list-sessions -F '#{session_attached}' | grep -q '^1$'; then
              tmux -S "$SOCKET" attach-session -t "$SESSION_NAME"
            fi
          else
            SESSION_NAME=$(zenity --entry --title="Welcome back, bosse@silvia" --text="Enter tmux session name:" 2>/dev/null)

            if [ -z "$SESSION_NAME" ] && [ -f "$SESSION_FILE" ]; then
              SESSION_NAME=$(cat "$SESSION_FILE")
            else
              SESSION_NAME=''${SESSION_NAME:-default}
            fi

            echo "$SESSION_NAME" >"$SESSION_FILE"
            tmux -S "$SOCKET" new-session -s "$SESSION_NAME"
          fi
        fi
      else
        :
      fi
    '';
  };
}
