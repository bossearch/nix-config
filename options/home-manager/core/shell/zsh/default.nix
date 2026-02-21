{
  homes,
  hosts,
  mylib,
  pkgs,
  ...
}: let
  kittyzsh = homes.kitty && hosts.shell == "zsh";
in {
  imports = mylib.autoimport ./.;

  programs.zsh = {
    enable = hosts.shell == "zsh";
    dotDir = ".config/zsh";
    history = {
      append = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
      path = "$HOME/.config/zsh/.zsh_history";
      size = 1000000;
      extended = false;
    };
    enableCompletion = true;
    shellAliases = {
      v = "nvim --startuptime /tmp/nvim-startup.log";
      vi = "nvim --startuptime /tmp/nvim-startup.log";
      vim = "nvim --startuptime /tmp/nvim-startup.log";
      nvim = "nvim --startuptime /tmp/nvim-startup.log";
      l = "eza --color=always";
      la = "eza -a --color=always";
      ll = "eza -al --color=always --no-user --no-permissions --no-filesize --no-time";
      lll = "eza -aloh --color=always --long";
      mv = "mv -i";
      rm = "rm -i";
      cp = "cp -i";
      c = "clear";
      cat = "bat";
      ".." = "cd ..";
      gh-create = "gh repo create --private --source=. --remote=origin && git push -u --all && gh browse";
    };
    envExtra = ''
      export EDITOR="nvim"
      export BAT_THEME="tokyonight_night"
      # export FZF_DEFAULT_OPTS="$(< ~/.config/fzf/.fzfrc)"
      # export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/.fzfrc
      export FZF_{CTRL_T,ALT_C}_OPTS="--preview='~/.config/fzf/extra/fzf-preview.sh {}'"
      export KEYTIMEOUT=1
      export AUTO_NOTIFY_THRESHOLD=5 # Set threshold to 30 seconds
      export AUTO_NOTIFY_IGNORE=(
        "nyaa"
        "rb" "hm" "nix-shell"
        "fh" "fkill" "fif" "fzf" "fsys" "fgrep"
        "yy" "sy" "yazi"
        "man" "nvim" "tmux" "tm" "fg"
        "lazygit" "newsboat" "toipe" "neomutt"
      )
    '';
    initContent = ''
      autoload -Uz ${pkgs.zsh-defer}/share/zsh-defer/zsh-defer
      zsh-defer source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      zsh-defer source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      zsh-defer source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      zsh-defer source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      zsh-defer source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      zsh-defer source ${pkgs.zsh-auto-notify}/share/zsh-auto-notify/zsh-auto-notify.plugin.zsh
      ZSH_AUTOSUGGEST_STRATEGY=(history)
      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down

      # fzf-tab settings for preview and completion
      # custom fzf flags
      zstyle ':fzf-tab:*' fzf-flags --height=50% --min-height=20
      zstyle ':fzf-tab:complete:*' fzf-preview \
      '[[ -d $realpath ]] && eza -1 --tree --level=2 --all --icons=always --color=always $realpath || \
      ([[ -f $realpath ]] && bat --color=always $realpath || \
      echo "Cannot preview")'
      setopt glob_dots

      # zsh-completions matcher settings
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      _comp_options+=(globdots)

      # Don't save wrong command to history
      zshaddhistory() { whence ''${''${(z)1}[1]} >| /dev/null || return 1 }

      # Source additional fzf files
      source ~/.config/zsh/functions/other
      source ~/.config/zsh/functions/fsys
      source ~/.config/zsh/functions/furl
      source ~/.config/zsh/functions/tmux

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh

      # my custom scripts
      rb() {
        ~/.nix-config/scripts/rebuild.sh "$@"
      }
      hm() {
        ~/.nix-config/scripts/homemanager.sh "$@"
      }

      # yazi with sudo
      function sy() {
        cd /
        local tmp="/tmp/yazi-cwd.XXXXXX"
        sudo -E yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd"
        fi
        sudo rm -f -- "$tmp"
      }

      # Show Nix Development Shell Name
      function prompt_nix_dev_shell_name() {
        if [[ -n $IN_NIX_SHELL ]]; then
          p10k segment -f grey -t "[nix-shell]"
        fi
      }

      # Show if Direnv Active
      function prompt_in_direnv() {
        if [[ -n $DIRENV_ACTIVE ]]; then
          p10k segment -f grey -t "[direnv]"
        fi
      }

      # Keybindings
      bindkey -v
      bindkey "^?" backward-delete-char
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey '^V' edit-command-line

      export KEYTIMEOUT=1

      # Yank on vicmd
      function vi-yank-xclip {
          zle vi-yank
          echo "$CUTBUFFER" | wl-copy
      }

      # Paste on vicmd
      zle -N vi-yank-xclip
      bindkey -M vicmd 'y' vi-yank-xclip
      function vi-paste-xclip {
          LBUFFER+=$(wl-paste)
      }
      zle -N vi-paste-xclip
      bindkey -M vicmd 'p' vi-paste-xclip
    '';
  };
  programs.kitty.shellIntegration = {
    enableZshIntegration = kittyzsh;
  };
}
