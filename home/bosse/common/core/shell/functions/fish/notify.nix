{
  notify = {
    onEvent = "fish_postexec";
    body = ''
      # List of commands to exclude
      set -l exclude_cmds \
          nyaa \
          rb hm nix-shell \
          fh fkill fif fzf fsys fgrep \
          yy sy yazi \
          v vi vim nvim \
          man tmux tm fg \
          lazygit newsboat toipe neomutt

      # Exit code and duration
      set -l exit_code $status
      set -l duration_ms $CMD_DURATION

      if test "$duration_ms" -lt 30000
          return
      end

      # Use saved command from fish_preexec
      set -l cmd $__last_cmd
      set -l cmd_name (string split ' ' $cmd)[1]

      if contains $cmd_name $exclude_cmds
          return
      end

      # Calculate duration in minutes and seconds
      set -l duration_sec (math -s0 "$duration_ms / 1000")
      set -l minutes (math -s0 "$duration_sec / 60")
      set -l seconds (math -s0 "$duration_sec % 60")
      set -l readable_duration ""

      if test $minutes -gt 0
          set readable_duration "$minutes"m
      end
      set readable_duration "$readable_duration$seconds"s

      set -l urgency normal
      set -l message "Took $readable_duration"

      if test "$exit_code" -ne 0
          set urgency critical
          set message "Exit: $exit_code · Took $readable_duration"
      end

      notify-send -u $urgency "$cmd" "$message"
    '';
  };
  savecmd = {
    onEvent = "fish_preexec";
    body = ''
      set -g __last_cmd $argv
    '';
  };
}
