{
  home.file.".config/zsh/functions/furl" = {
    text = ''
      furl() {
          local content urls wwws ips gits gh all_urls selected

          # Capture tmux pane and strip ANSI escape sequences
          content="$(tmux capture-pane -J -p -e | sed -r 's/\x1B\[[0-9;]*[mK]//g')"

          # Extract full URLs
          urls=$(echo "$content" | grep -oE '(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]')

          # Extract www. domains and prefix with http://
          wwws=$(echo "$content" | grep -oE '(http?s://)?www\.[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}(/\S+)?' |
                 grep -vE '^https?://' | sed 's|^|http://|')

          # Extract IP-based URLs and prefix with http://
          ips=$(echo "$content" | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}(:[0-9]{1,5})?(/\S+)?' |
                sed 's|^|http://|')

          # Convert SSH git URLs to https
          gits=$(echo "$content" | grep -oE '(ssh://)?git@\S+' |
                 sed -E 's/:/\//g; s/^(ssh\/\/\/)?git@(.+)$/https:\/\/\2/')

          # Extract GitHub user/repo references
          gh=$(echo "$content" | grep -oE "['\"]([_A-Za-z0-9-]+/[_.A-Za-z0-9-]+)['\"]" |
               sed "s/['\"]//g" | sed 's|^|https://github.com/|')

          # Combine and sort all URLs
          all_urls=$(
            {
              [ -n "$urls" ] && echo "$urls"
              [ -n "$wwws" ] && echo "$wwws"
              [ -n "$ips" ] && echo "$ips"
              [ -n "$gits" ] && echo "$gits"
              [ -n "$gh" ] && echo "$gh"
            } | sort -u
          )

          # If no URLs found, exit
          [ -z "$all_urls" ] && { echo "No URLs found in tmux pane."; return 1; }

          # Use fzf to pick a URL
          selected=$(echo "$all_urls" | fzf --prompt="Open URL > ")

          # Open the selected URL
          if [ -n "$selected" ]; then
              if command -v xdg-open &>/dev/null; then
                  nohup xdg-open "$selected" &>/dev/null &
              elif command -v open &>/dev/null; then
                  nohup open "$selected" &>/dev/null &
              elif [ -n "$BROWSER" ]; then
                  nohup "$BROWSER" "$selected" &>/dev/null &
              else
                  echo "No suitable method to open URL found."
                  return 1
              fi
          fi
      }
    '';
  };
}
