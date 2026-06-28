{
  hosts,
  lib,
  ...
}: {
  home.file.".config/zsh/functions/cheat" = lib.mkIf (hosts.shell == "zsh") {
    text = ''
      cheat() {
          local w=22

          print -P "%F{cyan}%BEmacs Keybindings (Zsh)%b%f"
          print

          print -P "%F{yellow}%BCursor Movement%b%f"
          printf "%-''${w}s %s\n" "Key" "Action"
          printf "%-''${w}s %s\n" "--------------------" "------------------------------"
          printf "%-''${w}s %s\n" "C-a" "Beginning of line"
          printf "%-''${w}s %s\n" "C-e" "End of line"
          printf "%-''${w}s %s\n" "C-f" "Forward character"
          printf "%-''${w}s %s\n" "C-b" "Backward character"
          printf "%-''${w}s %s\n" "M-f" "Forward word"
          printf "%-''${w}s %s\n" "M-b" "Backward word"

          print
          print -P "%F{yellow}%BEditing%b%f"
          printf "%-''${w}s %s\n" "Key" "Action"
          printf "%-''${w}s %s\n" "--------------------" "------------------------------"
          printf "%-''${w}s %s\n" "C-d" "Delete character under cursor"
          printf "%-''${w}s %s\n" "Backspace / C-h" "Delete previous character"
          printf "%-''${w}s %s\n" "M-d" "Delete next word"
          printf "%-''${w}s %s\n" "M-Backspace" "Delete previous word"
          printf "%-''${w}s %s\n" "C-w" "Kill previous word"
          printf "%-''${w}s %s\n" "C-k" "Kill to end of line"
          printf "%-''${w}s %s\n" "C-u" "Kill to beginning of line"
          printf "%-''${w}s %s\n" "C-y" "Yank (paste)"
          printf "%-''${w}s %s\n" "C-_" "Undo last action"
      }
    '';
  };
}
