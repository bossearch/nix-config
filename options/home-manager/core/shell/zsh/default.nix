{
  config,
  homes,
  hosts,
  lib,
  pkgs,
  ...
}: let
  init-tmux =
    if hosts.gui.enable
    then "bash ~/.config/zsh/init-tmux.sh"
    else "";
  kittyzsh = homes.kitty && hosts.shell == "zsh";
in {
  imports = [
    ./functions
    ./omp.nix
  ];

  programs.zsh = {
    enable = hosts.shell == "zsh";
    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      append = true;
      expireDuplicatesFirst = true;
      findNoDups = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      ignorePatterns = ["pass *" "fsys" "fsys *" "yy" "sy" "zsh" "c"];
      path = "${config.programs.zsh.dotDir}/.zsh_history";
      save = config.programs.zsh.history.size;
      saveNoDups = true;
      share = true;
      size = 10000;
    };
    shellAliases = {
      v = "nvim --startuptime /tmp/nvim-startup.log";
      vi = "nvim --startuptime /tmp/nvim-startup.log";
      vim = "nvim --startuptime /tmp/nvim-startup.log";
      nvim = "nvim --startuptime /tmp/nvim-startup.log";
      ls = "eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions";
      mv = "mv -i";
      rm = "rm -i";
      cp = "cp -i";
      c = "clear";
      cat = "bat --style=plain";
      bridge-disable = "nmcli con down br0";
      bridge-enable = "nmcli con up br0";
      gh-create = "gh repo create --private --source=. --remote=origin && git push -u --all && gh browse";
      nyaa = "setsid --fork transmission-gtk >/dev/null 2>&1 </dev/null; command nyaa $argv";
      z = "zoxide";
      lg = "lazygit";
    };
    completionInit = "autoload -U compinit && compinit -C";
    initContent = let
      zshrcBeforeCompInit = lib.mkOrder 500 ''
        bindkey -e
        autoload -Uz ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer
        zsh-defer source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        zsh-defer source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        zsh-defer source ${pkgs.zsh-completions}/share/zsh-completions/zsh-completions.zsh
        zsh-defer source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        zsh-defer source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      '';
      zshrcAfterCompInit = lib.mkOrder 1000 ''
        ${init-tmux}

        # Include hidden file
        setopt glob_dots

        # fzf preview
        _fzf_comprun() {
          local command=$1
          shift
          case "$command" in
            export|unset) fzf "$@" --preview='printenv {1}' ;;
            ssh) fzf "$@" ;;
            *) fzf "$@" --preview='~/.config/fzf/extra/fzf-preview.sh {}' ;;
          esac
        }

        # fzf-tab settings for preview and completion
        zstyle ':fzf-tab:*' use-fzf-default-opts yes
        zstyle ':fzf-tab:complete:*' fzf-preview \
        '[[ -d $realpath ]] && eza --tree --level=2 --all --icons=always --color=always $realpath || \
        ([[ -f $realpath ]] && bat -n --color=always $realpath || \
        echo "Cannot preview")'

        # zsh-completions matcher settings
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        _comp_options+=(globdots)

        # Don't save unvalid command to history
        zshaddhistory() { whence ''${''${(z)1}[1]} >| /dev/null || return 1 }

        # Keybindings
        bindkey "$terminfo[kcud1]" history-search-forward
        bindkey "$terminfo[kcuu1]" history-search-backward
        bindkey '^n' history-search-forward
        bindkey '^p' history-search-backward

        #Edit command line buffer in Neovim
        autoload -Uz edit-command-line
        zle -N edit-command-line
        bindkey '^x^e' edit-command-line

        # Copy to clipboard
        zclip-copy() {
          print -rn -- "$BUFFER" | wl-copy
        }
        zle -N zclip-copy
        bindkey '\e[50~"+y' zclip-copy

        # Source additional fzf files
        zsh-defer source ~/.config/zsh/functions/cheat
        zsh-defer source ~/.config/zsh/functions/expand
        zsh-defer source ~/.config/zsh/functions/fatcat
        zsh-defer source ~/.config/zsh/functions/notify
        zsh-defer source ~/.config/zsh/functions/fzf
        zsh-defer source ~/.config/zsh/functions/tmux
        zsh-defer source ~/.config/zsh/functions/yazi
      '';
    in
      lib.mkMerge [zshrcBeforeCompInit zshrcAfterCompInit];
  };
  programs.kitty.shellIntegration = {
    enableZshIntegration = kittyzsh;
  };
}
