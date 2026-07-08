{
  hosts,
  lib,
  ...
}: {
  home.file.".config/zsh/functions/fatcat" = lib.mkIf (hosts.shell == "zsh") {
    text = ''
      fatcat() {
        if (( $# == 0 )); then
            echo "Usage: fatcat <file>..."
            echo "Example:"
            echo "  fatcat *.lua"
            echo "  fatcat foo.lua bar.lua README.md"
            return 0
        fi

        printf '%s\n' "$PWD"
        local file

        for file in "$@"; do
            if [[ ! -f "$file" ]]; then
                printf 'fatcat: %s: not a regular file\n' "$file" >&2
                continue
            fi

            printf '```%s\n' "$file"
            \cat -- "$file"
            printf '```\n'
        done
      }
    '';
  };
}
