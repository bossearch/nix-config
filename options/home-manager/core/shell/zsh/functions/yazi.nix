{
  hosts,
  lib,
  ...
}: {
  home.file.".config/zsh/functions/yazi" = lib.mkIf (hosts.shell == "zsh") {
    text = ''
      # Regular yazi wrapper
      yy() {
          local tmp
          tmp=$(mktemp -t "yazi-cwd.XXXXX")
          local edit_handoff="/tmp/yazi-edit-handoff"
          rm -f "$edit_handoff"

          command yazi "$@" --cwd-file="$tmp"

          if [ -s "$tmp" ]; then
              local cwd
              read -r cwd < "$tmp"
              if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                  builtin cd -- "$cwd" || return
              fi
          fi
          rm -f -- "$tmp"

          if [ -f "$edit_handoff" ]; then
              local file_to_edit
              read -r file_to_edit < "$edit_handoff"
              rm -f "$edit_handoff"
              nvim "$file_to_edit"
          fi
      }

      # Sudo yazi wrapper
      sy() {
          local tmp
          tmp=$(mktemp -p "$HOME" -t "yazi-cwd.XXXXX")
          local edit_handoff="/tmp/yazi-edit-handoff"
          sudo rm -f "$edit_handoff"

          command sudo -E yazi "$@" --cwd-file="$tmp"

          if [ -s "$tmp" ]; then
              local cwd
              read -r cwd < "$tmp"
              if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                  builtin cd -- "$cwd" || return
              fi
          fi
          rm -f -- "$tmp"

          if [ -f "$edit_handoff" ]; then
              local file_to_edit
              read -r file_to_edit < "$edit_handoff"
              sudo rm -f "$edit_handoff"
              sudo nvim "$file_to_edit"
          fi
      }
    '';
  };
}
