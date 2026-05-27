{
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        run = "plugin ouch zip";
        on = ["C" "z"];
        desc = "Compress with ouch (zip)";
      }
      {
        run = "plugin ouch 7z";
        on = ["C" "7"];
        desc = "Compress with ouch (7z)";
      }
      {
        run = "plugin ouch rar";
        on = ["C" "r"];
        desc = "Compress with ouch (rar)";
      }
      {
        run = "plugin ouch tar";
        on = ["C" "t" "o"];
        desc = "Compress with ouch (tar) only";
      }
      {
        run = "plugin ouch tar.gs";
        on = ["C" "t" "g"];
        desc = "Compress with ouch (tar.gs)";
      }
      {
        run = "plugin ouch tar.xz";
        on = ["C" "t" "x"];
        desc = "Compress with ouch (tar.xz)";
      }
      {
        run = "plugin ouch tar.zst";
        on = ["C" "t" "z"];
        desc = "Compress with ouch (tar.zst)";
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
        run = "cd ~/.local/share/Trash/files";
        on = ["g" "t"];
        desc = "Go to trash";
      }
      {
        run = "cd ~/.nix-config/hosts";
        on = ["g" "n" "n"];
        desc = "nixconfig/hosts";
      }
      {
        run = "cd ~/.nix-config/homes";
        on = ["g" "n" "h"];
        desc = "nixconfig/homes";
      }
      {
        run = "cd ~/.nix-config/libs";
        on = ["g" "n" "l"];
        desc = "nixconfig/libs";
      }
      {
        run = "cd ~/.nix-config/modules/nixos";
        on = ["g" "n" "m" "n"];
        desc = "nixconfig/modules/nixos";
      }
      {
        run = "cd ~/.nix-config/modules/home-manager";
        on = ["g" "n" "m" "h"];
        desc = "nixconfig/modules/home-manager";
      }
      {
        run = "cd ~/.nix-config/options/nixos/core";
        on = ["g" "n" "o" "n" "c"];
        desc = "nixconfig/options/nixos/core";
      }
      {
        run = "cd ~/.nix-config/options/nixos/optional";
        on = ["g" "n" "o" "n" "o"];
        desc = "nixconfig/options/nixos/optional";
      }
      {
        run = "cd ~/.nix-config/options/home-manager/core";
        on = ["g" "n" "o" "h" "c"];
        desc = "nixconfig/options/home-manager/core";
      }
      {
        run = "cd ~/.nix-config/options/home-manager/optional";
        on = ["g" "n" "o" "h" "o"];
        desc = "nixconfig/options/home-manager/optional";
      }
      {
        run = "cd ~/.nix-config/overlays";
        on = ["g" "n" "O"];
        desc = "nixconfig/overlays";
      }
      {
        run = "cd ~/.nix-config/pkgs";
        on = ["g" "n" "p"];
        desc = "nixconfig/pkgs";
      }
      {
        run = "cd ~/.nix-config/themes";
        on = ["g" "n" "t"];
        desc = "nixconfig/themes";
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
