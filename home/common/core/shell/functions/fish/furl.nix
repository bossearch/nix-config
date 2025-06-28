{
  furl = ''
    set -l content (tmux capture-pane -J -p -e | sed -r 's/\x1B\[[0-9;]*[mK]//g')
    set -l all_urls (
        begin
            echo "$content" | grep -oE '(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'
            echo "$content" | grep -oE '(http?s://)?www\.[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}(/\S+)?' | grep -vE '^https?://' | sed 's|^|http://|'
            echo "$content" | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}(:[0-9]{1,5})?(/\S+)?' | sed 's|^|http://|'
            echo "$content" | grep -oE '(ssh://)?git@\S+' | sed -E 's/:/\//g; s/^(ssh\/\/\/)?git@(.+)$/https:\/\/\2/'
            echo "$content" | grep -oE "['\"]([_A-Za-z0-9-]+/[_.A-Za-z0-9-]+)['\"]" | sed "s/['\"]//g" | sed 's|^|https://github.com/|'
        end | sort -u | grep -v '^$'
    )
    if test (count $all_urls) -eq 0
        echo "No URLs found in tmux pane."
        return 1
    end
    set -l selected (printf '%s\n' $all_urls | fzf --prompt="Open URL > ")
    if test -n "$selected"
        if type -q xdg-open
            nohup xdg-open $selected >/dev/null 2>&1 &
        else if type -q open
            nohup open $selected >/dev/null 2>&1 &
        else if set -q BROWSER
            nohup $BROWSER $selected >/dev/null 2>&1 &
        else
            echo "No suitable method to open URL found."
            return 1
        end
    end
  '';
}
