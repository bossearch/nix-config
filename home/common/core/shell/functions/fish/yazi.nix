{
  yz = ''
    set -l tmp (mktemp -t "yazi-cwd.XXXXX")
    set -l edit_handoff "/tmp/yazi-edit-handoff"
    rm -f "$edit_handoff"
    command yazi $argv --cwd-file="$tmp"
    if read -l cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
    if test -f "$edit_handoff"
        set -l file_to_edit (cat "$edit_handoff")
        rm -f "$edit_handoff"
        nvim "$file_to_edit"
    end
  '';
  sy = ''
    set -l tmp (mktemp -t "yazi-cwd.XXXXX"  -p $HOME)
    set -l edit_handoff "/tmp/yazi-edit-handoff"
    sudo rm -f "$edit_handoff"
    command sudo -E yazi $argv --cwd-file="$tmp"
    if read -l cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
    if test -f "$edit_handoff"
        set -l file_to_edit (cat "$edit_handoff")
        sudo rm -f "$edit_handoff"
        sudo nvim "$file_to_edit"
    end
  '';
}
