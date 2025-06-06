{
  programs.yazi.keymap = {
    manager.prepend_keymap = [
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
        run = "cd ~/.nix-config";
        on = ["g" "n"];
        desc = "Go ~/.nix-config";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/core";
        on = ["n" "c"];
        desc = "nix-config/core";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/core/nvim";
        on = ["n" "n"];
        desc = "nix-config/neovim";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/core/cli/tmux";
        on = ["n" "t"];
        desc = "nix-config/tmux";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/core/cli/yazi";
        on = ["n" "y"];
        desc = "nix-config/yazi";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/core/cli/fzf";
        on = ["n" "f"];
        desc = "nix-config/fzf";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/core/zsh";
        on = ["n" "z"];
        desc = "nix-config/zsh";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/optional";
        on = ["n" "o"];
        desc = "nix-config/optional";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/optional/hyprland";
        on = ["n" "h"];
        desc = "nix-config/hyprland";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/optional/mpv";
        on = ["n" "m"];
        desc = "nix-config/mpv";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/optional/waybar";
        on = ["n" "w"];
        desc = "nix-config/waybar";
      }
      {
        run = "cd ~/.nix-config/home/bosse/common/optional/firefox";
        on = ["n" "b"];
        desc = "nix-config/browser";
      }
    ];
  };
}
