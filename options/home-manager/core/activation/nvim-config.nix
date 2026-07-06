{pkgs, ...}:
pkgs.writeShellScript "nvim-config" ''
  case "$1" in
  nix)
    if [ -L "$HOME/.config/nvim" ]; then
      rm -f "$HOME/.config/nvim"
    fi
    ;;
  lua)
    if [ ! -L "$HOME/.config/nvim" ]; then
      rm -rf "$HOME/.config/nvim"
    fi
    ;;
  clone)
    if [[ ! -d "$HOME/Devs/nvim-config" ]]; then
      ${pkgs.git}/bin/git clone "https://github.com/bossearch/nvim-config" "$HOME/Devs/nvim-config"
    fi
    ;;
  esac
''
