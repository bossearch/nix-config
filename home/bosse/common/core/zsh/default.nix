{pkgs, ...}: {
  imports = [
    ./.p10k.nix
  ];
  programs.zsh = {
    enable = true;
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
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "v1.2.0";
          sha256 = "sha256-q26XVS/LcyZPRqDNwKKA9exgBByE0muyuNb0Bbar2lY=";
        };
      }
      {
        name = "zsh-auto-notify";
        file = "auto-notify.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-auto-notify";
          rev = "cac2c193d9f227c99178ca7cf9e25152a36dd4ac";
          sha256 = "sha256-8r5RsyldJIzlWr9+G8lrkHvJ8KxTVO859M//wDnYOUY=";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
        };
      }
    ];
    shellAliases = {
      v="nvim --startuptime /tmp/nvim-startup.log";
      vi="nvim --startuptime /tmp/nvim-startup.log";
      vim="nvim --startuptime /tmp/nvim-startup.log";
      nvim="nvim --startuptime /tmp/nvim-startup.log";
      l = "eza --color=always";
      la = "eza -a --color=always";
      ll = "eza -al --color=always --no-user --no-permissions --no-filesize --no-time";
      lll = "eza -aloh --color=always --long";
      mv = "mv -i";
      rm = "rm -i";
      cp = "cp -i";
      editzsh = "nvim ~/.config/zsh/.zshrc";
      c = "clear";
      cat = "bat";
      cat-og = "\cat";
      gh-create="gh repo create --private --source=. --remote=origin && git push -u --all && gh browse";
      ".." = "cd ..";
    };
    envExtra = ''
      export EDITOR="nvim"
      export BAT_THEME="tokyonight_night"
      export FZF_DEFAULT_OPTS="$(< ~/.config/fzf/.fzfrc)"
      export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/.fzfrc
      export FZF_{CTRL_T,ALT_C}_OPTS="--preview='~/.config/fzf/extra/fzf-preview.sh {}'"
      export KEYTIMEOUT=1
      export AUTO_NOTIFY_THRESHOLD=30 # Set threshold to 30 seconds
      export AUTO_NOTIFY_IGNORE=(
        "nyaa"
        "rb" "hm" "nix-shell"
        "fh" "fkill" "fif" "fzf" "fsys" "fgrep"
        "yy" "sy" "yazi"
        "man" "nvim" "tmux" "tm" "fg"
        "lazygit" "newsboat" "toipe" "neomutt"
      )
    '';
    initExtraFirst = ''
    '';
    initExtra = ''
      # Don't save wrong command to history
      zshaddhistory() { whence ''${''${(z)1}[1]} >| /dev/null || return 1 }

      # Source additional fzf files
      source ~/.config/fzf/extra/other
      source ~/.config/fzf/extra/fsys
      source ~/.config/fzf/extra/furl

      # Check if tmux is installed and load fzf scripts
      if command -v tmux >/dev/null 2>&1; then
        source ~/.config/fzf/extra/tmux
      fi

      # powerlevel10k
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
    '';
    initExtraBeforeCompInit = ''
    '';
  };
}
