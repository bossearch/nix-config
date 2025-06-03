{
  tm = ''
    if set -q TMUX
      set change "switch-client"
    else
      set change "attach-session"
    end

    if test (count $argv) -gt 0
      tmux $change -t "$argv[1]" 2>/dev/null
      or begin
          tmux new-session -d -s "$argv[1]"
          tmux $change -t "$argv[1]"
      end
      return
    end

    set -l session (tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height=100% --exit-0 \
      --bind 'j:down,k:up,space:accept')

    if test -n "$session"
      tmux $change -t "$session"
    else
      echo "No sessions found."
    end
  '';
}
