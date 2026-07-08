{
  fatcat = ''
    if test (count $argv) -eq 0
        echo "Usage: fatcat <file>..."
        echo "Example:"
        echo "  fatcat *.lua"
        echo "  fatcat foo.lua bar.lua README.md"
        return 0
    end

    printf '%s\n' $PWD

    for file in $argv
        if not test -f "$file"
            printf 'fatcat: %s: not a regular file\n' "$file" >&2
            continue
        end

        printf '```%s\n' "$file"
        command cat -- "$file"
        printf '```\n'
    end
  '';
}
