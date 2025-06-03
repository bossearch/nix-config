{
  pane = ''
    set -l panes (tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
    set -l current_pane (tmux display-message -p '#I:#P')
    set -l current_window (tmux display-message -p '#I')

    # Properly filter and pipe to fzf
    set -l target (printf "%s\n" $panes | grep -v "$current_pane" | fzf --height=100% --reverse \
      --bind 'j:down,k:up,space:accept')

    if test -z "$target"
      return
    end

    # Extract target window and pane
    set -l target_window (echo $target | awk 'BEGIN{FS=":|-"} {print $1}')
    set -l target_pane (echo $target | awk 'BEGIN{FS=":|-"} {print $2}' | string sub -l 1)

    if test "$current_window" = "$target_window"
      tmux select-pane -t "$target_window.$target_pane"
    else
      tmux select-pane -t "$target_window.$target_pane"
      tmux select-window -t "$target_window"
    end
  '';
}
