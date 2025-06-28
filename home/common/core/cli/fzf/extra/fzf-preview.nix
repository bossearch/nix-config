{
  home.file.".config/fzf/extra/fzf-preview.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      file="$1"

      if [ -d "$file" ]; then
        eza -1 --tree --level=2 --all --icons=always --color=always "$file"
      elif [ -f "$file" ]; then
        bat --color=always --style=plain --theme=ansi "$file"
      else
        echo 'Not a file or directory'
      fi
    '';
  };
}
