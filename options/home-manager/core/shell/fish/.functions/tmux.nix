{
  tm = ''
    set -l choice (tmux list-session | fzf \
        --prompt="session ❯ " \
        --multi \
        --bind "j:down,k:up,x:execute(for sid in {+1}; set -l clean_sid (string split -m 1 : \$sid)[1]; tmux kill-session -t \$clean_sid; end)+abort"
    )
    or return

    set -l target_session (string split -m 1 : -- $choice[1])[1]
    if test -n "$target_session"
        tmux switch-client -t "$target_session"
    end
  '';
  pane = ''
    set -l fmt "#{pane_id} "
    set fmt "$fmt#{window_index}.#{pane_index} "
    set fmt "$fmt#{?pane_active,●,○} "
    set fmt "$fmt[#{pane_width}x#{pane_height}] "
    set fmt "$fmt#{pane_current_command}#{?pane_dead, (dead),} "
    set fmt "$fmt@ #{s|#{HOME}|~|:pane_current_path}"

    set -l choice (tmux list-panes -s -F "$fmt" | fzf \
        --with-nth=2.. \
        --prompt="pane ❯ " \
        --multi \
        --bind "j:down,k:up,x:execute(for pid in {+1}; tmux kill-pane -t \$pid; end)+abort" \
    )
    or return

    set -l target_pane (string split ' ' -- $choice[1])[1]

    if test -n "$target_pane"
        tmux switch-client -t "$target_pane"
    end
  '';
  furl = ''
    set -l content (tmux capture-pane -J -p -e | sed -r 's/\x1B\[[0-9;]*[mK]//g')
    set -l all_urls (
        begin
            echo "$content" | grep -oE '(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'
            echo "$content" | grep -oE '(http?s://)?www\.[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}(/\S+)?' | grep -vE '^https?://' | sed 's|^|http://|'
            echo "$content" | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}(:[0-9]{1,5})?(/\S+)?' | sed 's|^|http://|'
            echo "$content" | grep -oE '(ssh://)?git@\S+' | sed -E 's/:/\//g; s/^(ssh\/\/\/)?git@(.+)$/https:\/\/\2/'
            echo "$content" | grep -oE '(~/|/home/'$USER'/)[A-Za-z0-9._\/-]+' | sed "s|^~|$HOME|"
        end | sort -u | grep -v '^$'
    )
    if test (count $all_urls) -eq 0
        echo "No URLs found in tmux pane."
        return 1
    end
    set -l selected (printf '%s\n' $all_urls | fzf --prompt="furl > ")

    if test -n "$selected"
        if type -q xdg-open
            setsid --fork xdg-open "$selected" >/dev/null 2>&1 </dev/null
        else if type -q open
            setsid --fork open "$selected" >/dev/null 2>&1 </dev/null
        else if set -q BROWSER
            setsid --fork $BROWSER "$selected" >/dev/null 2>&1 </dev/null
        else
            echo "No suitable method to open URL found."
            return 1
        end
    end
  '';
}
