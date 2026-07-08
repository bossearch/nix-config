{
  hosts,
  mylib,
  pkgs,
  ...
}: let
  exec =
    if hosts.shell == "fish"
    then {
      prefix = "fish -c";
      suffx = "";
    }
    else if hosts.shell == "zsh"
    then {
      prefix = "zsh -c 'source /home/bosse/.config/zsh/functions/tmux &&";
      suffix = "'";
    }
    else "";
in {
  imports = mylib.autoimport ./.;

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    terminal = "tmux-256color";
    mouse = true;
    keyMode = "vi";
    historyLimit = 10000;
    focusEvents = true;
    aggressiveResize = true;
    secureSocket = true;
    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display-message -d 2000 "Tmux Reloaded"

      # Tmux config
      set -s set-clipboard on
      set -g set-titles on
      set -g allow-passthrough on
      set-option -g status-position top
      set-option -g renumber-windows on

      # show undercurl inside tmux
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      # Tmux sensible
      set -g status-interval 1
      set -g status-keys emacs

      # prefix
      unbind C-b
      set -g prefix M-Space
      bind-key Space last-window

      # copy mode
      unbind f
      bind f copy-mode

      # window navigation
      bind -n M-h previous-window
      bind -n M-l next-window
      # bind -r C-p previous-window
      # bind -r C-n next-window

      # pane control
      unbind h
      unbind j
      unbind k
      unbind l
      unbind s
      bind -r h resize-pane -L
      bind -r j resize-pane -D
      bind -r k resize-pane -U
      bind -r l resize-pane -R
      bind -r s swap-pane -D

      # Split
      unbind %
      unbind '"'
      bind | split-window -h
      bind - split-window -v

      # Selection mode (vi mode)
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle \; send -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Fzf
      unbind o
      unbind q
      unbind w
      bind o popup -E -B -w80 -h10 -xC -yC "${exec.prefix} furl${exec.suffix}"
      bind w popup -E -B -w80 -h10 -xC -yC "${exec.prefix} pane${exec.suffix}"
      bind q popup -E -B -w80 -h10 -xC -yC "${exec.prefix} tm${exec.suffix}"

      # my plugin
      run-shell ~/.config/tmux/plugins/mythemux/mythemux.tmux
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left "C-h"
          set -g @vim_navigator_mapping_right "C-l"
          set -g @vim_navigator_mapping_up "C-k"
          set -g @vim_navigator_mapping_down "C-j"
          set -g @vim_navigator_mapping_prev ""
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          resurrect_dir="$HOME/.local/state/tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all "sed -i -E 's|:[^[:space:]]*/nvim[[:space:]].*|:nvim|' \$resurrect_dir/last"
          set -g @resurrect-processes '~nvim ~yazi'
        '';
      }
    ];
  };
}
