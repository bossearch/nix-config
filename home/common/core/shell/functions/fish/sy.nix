{
  sy = ''
    cd /
    set -l tmp (mktemp -t "yazi-cwd.XXXXX" -p $HOME)
    command sudo -E yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
  '';
}
