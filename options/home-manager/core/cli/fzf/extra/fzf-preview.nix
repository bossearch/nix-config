{
  home.file.".config/fzf/extra/fzf-preview.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      FILE="$1"

      if [ -d "$FILE" ]; then
        eza -1 --tree --level=2 --all --icons=always --color=always "$FILE"
      elif [ -f "$FILE" ]; then
        bat --color=always --style=plain --theme=ansi "$FILE"
      else
        echo 'Not a file or directory'
      fi
    '';
  };
}
