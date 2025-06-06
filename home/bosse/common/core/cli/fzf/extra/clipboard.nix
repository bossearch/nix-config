{
  home.file.".config/fzf/extra/clipboard.sh" = {
    executable = true;
    text = ''
      cliphist list -n | fzf -d $'\t' --with-nth 2 --layout=default --border=none \
        --preview='echo {} | cut -f1 | xargs cliphist decode' --preview-window=up:wrap \
        | cut -f1 | xargs cliphist decode | wl-copy
    '';
  };
}
