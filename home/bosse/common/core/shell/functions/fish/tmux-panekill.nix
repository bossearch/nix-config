{
  panekill = ''
    set -l windowpanes (tmux list-panes -s | fzf --exit-0 --multi --height=100% \
      --bind 'j:down,k:up,space:accept')

    if test -z "$windowpanes"
      return
    end

    set -l sorted_panes (printf "%s\n" $windowpanes | sort -t':' -k1,1nr -k2,2nr)

    for line in $sorted_panes
      # Extract the pane ID (everything before the first colon)
      set -l pane_id (echo $line | awk -F: '{print $1}')

      if test -n "$pane_id"
        echo "Killing $pane_id"
        tmux kill-pane -t "$pane_id"
      end
    end
  '';
}
