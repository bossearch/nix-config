{
  home.file.".config/yazi/opener.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      FILE="$1"
      if [ -z "$TMUX" ]; then
        kitty nvim "$FILE"
      else
        ya emit quit
        SOCKET=''${SOCKET:-''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/tmux-$(id -u)/default}
        CURRENT_PANE=$(tmux -S "$SOCKET" display-message -p '#{session_name}:#{window_index}.#{pane_index}')
        tmux -S "$SOCKET" send-keys -t "$CURRENT_PANE" " nvim \"$FILE\"" C-m
      fi
    '';
  };
}
