{
  home.file.".config/zsh/functions/other" = {
    text = ''
      # fh - repeat history
      fh() {
        print -z $(
          ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | \
          fzf +s --tac --preview-window hidden | \
          sed -E 's/ *[0-9]*\*? *//' | \
          sed -E 's/\\/\\\\/g'
        )
      }

      # fkill - kill processes - list only the ones you can kill. Modified the earlier script.
      fkill() {
          local pid
          if [ "$UID" != "0" ]; then
              pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
          else
              pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
          fi

          if [ "x$pid" != "x" ]
          then
              echo $pid | xargs kill -''${1:-9}
          fi
      }

      # using ripgrep combined with preview
      # find-in-file - usage: fif <searchTerm>
      fgrep() {
        if [ ! "$#" -gt 0 ]; then
          echo "Need a string to search for!"
          return 1
        fi

        # Use rg to search and fzf to preview the matches
        selected_file=$(rg --files-with-matches --no-messages "$1" | fzf \
        --height=~30  --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' \
        --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"\
        --preview-window=down,30)

        # Check if a file was selected
        if [ -n "$selected_file" ]; then
          # Open the selected file in nvim
          nvim "$selected_file"
        fi
      }
    '';
  };
}
