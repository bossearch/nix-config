{
  fgrep = ''
    if test (count $argv) -eq 0
        echo "Need a string to search for!"
        return 1
    end

    # Use rg to search and fzf to preview the matches
    set -l selected_file (rg --files-with-matches --no-messages "$argv[1]" | fzf \
    --height=~30  --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' \
    --ignore-case --pretty --context 10 '$argv[1]' || rg --ignore-case --pretty --context 10 '$argv[1]' {}" \
    --preview-window=down,30)

    if test -n "$selected_file"
        nvim "$selected_file"
    end
  '';
}
