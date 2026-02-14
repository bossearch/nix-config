{
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        run = "plugin ouch --args=zip";
        on = ["C"];
        desc = "Compress with ouch";
      }
      {
        run = "plugin smart-enter";
        on = ["l"];
        desc = "Enter the child directory, or open the file";
      }
      {
        run = "plugin smart-paste";
        on = ["p"];
        desc = "Paste into the hovered directory or CWD";
      }
      {
        run = "plugin chmod";
        on = ["c" "m"];
        desc = "Chmod on selected files";
      }
      {
        run = "cd ~/Desktop";
        on = ["g" "x"];
        desc = "Go ~/Desktop";
      }
      {
        run = "cd ~/Documents";
        on = ["g" "D"];
        desc = "Go ~/Documents";
      }
      {
        run = "cd ~/Pictures";
        on = ["g" "p"];
        desc = "Go ~/Pictures";
      }
      {
        run = "cd ~/Videos";
        on = ["g" "v"];
        desc = "Go ~/Videos";
      }
      {
        run = "cd ~/.local/share/Vaults";
        on = ["g" "V"];
        desc = "Go to vaults";
      }
      {
        run = "cd ~/.local/share/Trash/files";
        on = ["g" "t"];
        desc = "Go to trash";
      }
      {
        run = "cd ~/.nix-config/hosts";
        on = ["g" "N" "."];
        desc = "nixconfig/hosts";
      }
      {
        run = "cd ~/.nix-config/hosts/common/core";
        on = ["g" "N" "c"];
        desc = "nixconfig/hosts.../core";
      }
      {
        run = "cd ~/.nix-config/hosts/common/optional";
        on = ["g" "N" "o"];
        desc = "nixconfig/hosts.../optional";
      }
      {
        run = "cd ~/.nix-config/hosts/droid";
        on = ["g" "N" "d"];
        desc = "nixconfig/hosts.../droid";
      }
      {
        run = "cd ~/.nix-config/modules";
        on = ["g" "N" "m"];
        desc = "nixconfig/modules";
      }
      {
        run = "cd ~/.nix-config/overlays";
        on = ["g" "N" "O"];
        desc = "nixconfig/overlays";
      }
      {
        run = "cd ~/.nix-config/pkgs";
        on = ["g" "N" "p"];
        desc = "nixconfig/pkgs";
      }
      {
        run = "cd ~/.nix-config/home";
        on = ["g" "n" "."];
        desc = "nixconfig/home";
      }
      {
        run = "cd ~/.nix-config/home/common/core";
        on = ["g" "n" "c"];
        desc = "nixconfig/home.../core";
      }
      {
        run = "cd ~/.nix-config/home/common/core/nvim";
        on = ["g" "n" "n"];
        desc = "nixconfig/home.../neovim";
      }
      {
        run = "cd ~/.nix-config/home/common/core/cli/tmux";
        on = ["g" "n" "t"];
        desc = "nixconfig/home.../tmux";
      }
      {
        run = "cd ~/.nix-config/home/common/core/cli/yazi";
        on = ["g" "n" "y"];
        desc = "nixconfig/home.../yazi";
      }
      {
        run = "cd ~/.nix-config/home/common/core/cli/fzf";
        on = ["g" "n" "f"];
        desc = "nixconfig/home.../fzf";
      }
      {
        run = "cd ~/.nix-config/home/common/core/shell";
        on = ["g" "n" "s"];
        desc = "nixconfig/home.../shell";
      }
      {
        run = "cd ~/.nix-config/home/common/optional";
        on = ["g" "n" "o"];
        desc = "nixconfig/home.../optional";
      }
      {
        run = "cd ~/.nix-config/home/common/optional/hyprland";
        on = ["g" "n" "h"];
        desc = "nixconfig/home.../hyprland";
      }
      {
        run = "cd ~/.nix-config/home/common/optional/mpv";
        on = ["g" "n" "m"];
        desc = "nixconfig/home.../mpv";
      }
      {
        run = "cd ~/.nix-config/home/common/optional/waybar";
        on = ["g" "n" "w"];
        desc = "nixconfig/home.../waybar";
      }
      {
        on = ["c" "d"];
        desc = "Duplicate file, folder or symlink";
        run = ''
          shell -- for f in "$@"; do
            if [ -d "$f" ] && [ ! -L "$f" ]; then
              base="$f"; ext=""
            else
              fname="''${f##*/}"
              case "''${fname#.}" in
                *.*)
                  base="''${f%.*}"
                  ext=".''${f##*.}"
                  ;;
                *)
                  base="$f"
                  ext=""
                  ;;
              esac
            fi
            count=1
            target="''${base}_$count$ext"
            while [ -e "$target" ]; do
              count=$((count + 1))
              target="''${base}_$count$ext"
            done
            if [ -L "$f" ]; then
              mv -- "$f" "$target"
              cp -pLR --no-preserve=mode,ownership -- "$target" "$f"
              chmod -R u+rw "$f"
            else
              cp -a -- "$f" "$target"
            fi
          done
        '';
      }
    ];
  };
}
