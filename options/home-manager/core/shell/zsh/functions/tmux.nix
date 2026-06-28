{
  hosts,
  lib,
  ...
}: {
  home.file.".config/zsh/functions/tmux" = lib.mkIf (hosts.shell == "zsh") {
    text = ''
      tm() {
        local choice
        choice=$(tmux list-session | fzf \
          --prompt="session ❯ " \
          --multi \
          --bind "j:down,k:up,x:execute(for sid in {+1}; do tmux kill-session -t \$sid; done)+reload(tmux list-sessions)" \
        ) || return $?

        local target_session
        target_session=$(echo "$choice" | head -n1 | awk '{print $1}')

        if [[ -n "$target_session" ]]; then
          tmux switch-client -t "$target_session"
        fi
      }

      pane() {
        local fmt=""
        fmt+="#{pane_id} "
        fmt+="#{window_index}.#{pane_index} "
        fmt+="#{?pane_active,●,○} "
        fmt+="[#{pane_width}x#{pane_height}] "
        fmt+="#{pane_current_command}#{?pane_dead, (dead),} "
        fmt+="@ #{s|#{HOME}|~|:pane_current_path}"

        local choice
        choice=$(tmux list-panes -s -F "$fmt" | fzf \
          --with-nth=2.. \
          --prompt="pane ❯ " \
          --multi \
          --bind "j:down,k:up,x:execute(for pid in {+1}; do tmux kill-pane -t \$pid; done)+reload<tmux list-panes -s -F '$fmt'>" \
        ) || return $?

        local target_pane
        target_pane=$(echo "$choice" | head -n1 | awk '{print $1}')

        if [[ -n "$target_pane" ]]; then
          tmux switch-client -t "$target_pane"
        fi
      }

      furl() {
        local content selected
        local -a all_urls

        content=$(tmux capture-pane -J -p)
        all_urls+=( ''${(f)"$(echo "$content" | grep -oE '(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]')"} )
        all_urls+=( ''${(f)"$(echo "$content" | grep -oE '(https?://)?www\.[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}(/\S+)?' | grep -vE '^https?://' | sed 's|^|http://|')"} )
        all_urls+=( ''${(f)"$(echo "$content" | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}(:[0-9]{1,5})?(/\S+)?' | sed 's|^|http://|')"} )
        all_urls+=( ''${(f)"$(echo "$content" | grep -oE '(ssh://)?git@\S+' | sed -E 's/:/\//g; s/^(ssh\/\/\/)?git@(.+)$/https:\/\/\2/')"} )
        all_urls+=( ''${(f)"$(echo "$content" | grep -oE '(~/|/home/'$USER'/)[A-Za-z0-9._\/-]+' | sed "s|^~|$HOME|")"} )

        all_urls=( ''${(u)all_urls:#} )

        if (( ''${#all_urls} == 0 )); then
          print "No URLs found in tmux pane." >&2
          return 1
        fi

        selected=$(print -l "''${all_urls[@]}" | sort | fzf --prompt="furl ❯ ")

        if [[ -n "$selected" ]]; then
          if (( $+commands[xdg-open] )); then
            setsid xdg-open "$selected" >/dev/null 2>&1 &
          elif (( $+commands[open] )); then
            open "$selected" >/dev/null 2>&1 &
          elif [[ -n "$BROWSER" ]]; then
            setsid "$BROWSER" "$selected" >/dev/null 2>&1 &
          else
            print "No suitable method to open URL found." >&2
            return 1
          fi
          sleep 0.05
        fi
      }

    '';
  };
}
