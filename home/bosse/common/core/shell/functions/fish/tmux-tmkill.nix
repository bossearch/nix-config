{
  tmkill = ''
    # Get selected sessions (can be multiple lines)
    set -l sessions (tmux ls | fzf --exit-0 --multi --bind 'j:down,k:up,space:accept')

    if test -z "$sessions"
        return
    end

    for line in $sessions
        # Extract session name before the colon
        set -l session_name (string split ":" -- $line | head -n1)

        if test -n "$session_name"
            echo "Killing $session_name"
            tmux kill-session -t "$session_name"
        end
    end
  '';
}
