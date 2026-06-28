{
  hosts,
  lib,
  ...
}: {
  home.file.".config/zsh/functions/notify" = lib.mkIf (hosts.shell == "zsh") {
    text = ''
      _auto_notify_track() {
          AUTO_NOTIFY_CMD="$1"
          AUTO_NOTIFY_START=$(date +"%s")
      }

      _auto_notify_send() {
          local exit_code=$?

          if [[ -z "$AUTO_NOTIFY_START" || -z "$AUTO_NOTIFY_CMD" ]]; then
              return
          fi

          local current=$(date +"%s")
          local duration=$(( current - AUTO_NOTIFY_START ))

          local cmd="$AUTO_NOTIFY_CMD"
          unset AUTO_NOTIFY_START
          unset AUTO_NOTIFY_CMD

          if [[ $duration -lt 30 ]]; then
              return
          fi

          local check_cmd="''${cmd##[[:space:]]}" # Strip leading spaces
          if [[ "$check_cmd" == "sudo "* ]]; then
              check_cmd="''${check_cmd#sudo }"  # Bypass sudo prefix safely
          fi

          local ignored_cmds=(
              "nyaa"
              "rb" "hm" "nix-shell"
              "fkill" "fzf" "fsys" "fgrep"
              "yy" "sy" "yazi"
              "man" "tmux" "fg"
              "lazygit" "newsboat" "toipe" "neomutt"
              "v" "vi" "vim" "nvim"
          )

          for ignore in "''${ignored_cmds[@]}"; do
              if [[ "$check_cmd" == "$ignore" || "$check_cmd" == "$ignore "* ]]; then
                  return
              fi
          done

          local urgency="normal"
          local message="Took ''${duration}s"

          if [[ $exit_code -ne 0 ]]; then
              urgency="critical"
              message="Exit: $exit_code  · Took ''${duration}s"
          fi
          notify-send -u "$urgency" "$cmd" "$message" --app-name=fish -i utilities-terminal
      }

      autoload -Uz add-zsh-hook
      add-zsh-hook preexec _auto_notify_track
      add-zsh-hook precmd _auto_notify_send
    '';
  };
}
