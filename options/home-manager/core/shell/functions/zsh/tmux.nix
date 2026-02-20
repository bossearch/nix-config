{
  hosts,
  lib,
  ...
}: {
  home.file.".config/zsh/functions/tmux" = lib.mkIf (hosts.shell == "zsh") {
    text = ''
      # zsh; needs setopt re_match_pcre. You can, of course, adapt it to your own shell easily.
      tmuxkill () {
        local sessions
        sessions="$(tmux ls|fzf --exit-0 --multi --bind 'j:down,k:up,space:accept')"  || return $?
        local i
        for i in "''${(f@)sessions}"
        do
        [[ $i =~ '([^:]*):.*' ]] && {
          echo "Killing $match[1]"
          tmux kill-session -t "$match[1]"
        }
        done
      }
      # tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
      # `tm` will allow you to select your tmux session via fzf.
      # `tm irc` will attach to the irc session (if it exists), else it will create it.

      tm() {
        [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
        if [ $1 ]; then
          tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
        fi
        session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --height 100% --exit-0 \
        --bind 'j:down,k:up,space:accept') \
        &&  tmux $change -t "$session" || echo "No sessions found."
      }

      # ftpane - switch pane (@george-b)
      ftpane() {
        local panes current_window current_pane target target_window target_pane
        panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
        current_pane=$(tmux display-message -p '#I:#P')
        current_window=$(tmux display-message -p '#I')

        target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --height 100% --reverse \
        --bind 'j:down,k:up,space:accept') || return

        target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
        target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

        if [[ $current_window -eq $target_window ]]; then
          tmux select-pane -t ''${target_window}.''${target_pane}
        else
          tmux select-pane -t ''${target_window}.''${target_pane} &&
          tmux select-window -t $target_window
        fi
      }

      ftpanekill() {
        local windowpanes
        # Get the list of panes and select with fzf
        windowpanes=$(tmux list-panes -s | fzf --exit-0 --multi --height 100%\
          --bind 'j:down,k:up,space:accept') || return $?

        # Sort the selected panes by window and pane number in descending order
        local sorted_panes
        sorted_panes=$(echo "$windowpanes" | sort -t':' -k1,1nr -k2,2nr)
        echo "''${sorted_panes}"

        local i
        for i in "''${(f@)sorted_panes}"
        do
          [[ $i =~ '([^:]*):.*' ]] && {
              echo "Killing $match[1]"
              tmux kill-pane -t "$match[1]"
          }
        done
      }
    '';
  };
}
