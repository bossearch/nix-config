{
  notify = {
    onEvent = "fish_postexec";
    body = ''
      # List of commands to exclude
      set -l exclude_cmds \
        "nyaa" \
        "rb" "hm" "nix-shell" \
        "fh" "fkill" "fif" "fzf" "fsys" "fgrep" \
        "yy" "sy" "yazi" \
        "v" "vi" "vim" "nvim" \
        "man" "tmux" "tm" "fg" \
        "lazygit" "newsboat" "toipe" "neomutt"

      # Exit code and duration
      set -l exit_code $status
      set -l duration_ms $CMD_DURATION

      if test "$duration_ms" -lt 5000
          return
      end

      # Use saved command from fish_preexec
      set -l cmd $__last_cmd
      set -l cmd_name (string split ' ' $cmd)[1]

      if contains $cmd_name $exclude_cmds
          return
      end

      set -l urgency normal
      if test "$exit_code" -ne 0
          set urgency critical
      end

      set -l title "$cmd"
      set -l message "Exit: $exit_code"

      notify-send -u $urgency "$title" "$message" --icon=utilities-terminal --app-name=fish
    '';
  };
}
