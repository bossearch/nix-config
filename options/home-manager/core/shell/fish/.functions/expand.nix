{
  __fish_expand_bang = ''
    switch (commandline -t)
        case '!'
            commandline -t $history[1]
        case '*'
            commandline -i '!'
    end
  '';
  __fish_expand_dots = ''
    set -l cmd (commandline --cut-at-cursor)
    set -l split (string split -- ' ' $cmd)
    if string match --quiet --regex -- '^(\.\./)*\.\.$' $split[-1]
        commandline --insert '/..'
    else
        commandline --insert '.'
    end
  '';
  __fish_expand_args = ''
    switch (commandline -t)
        case '!'
            commandline -t ""
            commandline -f history-token-search-backward
        case '*'
            commandline -i '$'
    end
  '';
}
