{
  home.file.".config/fzf/extra/clipboard.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      cliphist list -n | fzf \
        --delimiter=$'\t' \
        --with-nth=2 \
        --layout=default \
        --height=100% \
        --min-height=20 \
        --ansi \
        --border=none \
        --preview='echo {} | cut -f1 | xargs cliphist decode | bat --color=always --style=plain --language=bash' \
        --preview-window=top:70% |
        cut -f1 | xargs cliphist decode | wl-copy
    '';
  };
}
