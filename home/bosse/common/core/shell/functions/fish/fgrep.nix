{
  fgrep = ''
    if test (count $argv) -eq 0
        echo "Need a string to search for!"
        return 1
    end

    set -l selected_file (rg --files-with-matches --no-messages "$argv[1]" | fzf --height=~30 \
    --preview "bat --color=always --style=plain {} | \
    rg --color=always --colors 'match:bg:black' --ignore-case --context 10 '$argv[1]'" \
    --preview-window=down,30)

    if test -n "$selected_file"
        nvim "$selected_file"
    end
  '';
}
