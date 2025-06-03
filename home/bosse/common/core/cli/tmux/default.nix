{pkgs, ...}: {
  imports = [
    ./mythemux.nix
  ];
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    terminal = "tmux-256color";
    mouse = true;
    keyMode = "vi";
    historyLimit = 10000;
    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display-message -d 2000 "Tmux Reloaded"

      # Tmux config
      set -s set-clipboard on
      set -g set-titles on
      set -g allow-passthrough on
      set-option -g status-position top
      set-option -g renumber-windows on

      # Tmux sensible
      set -g status-interval 1
      set -g status-keys vi
      set -g focus-events on

      # bindkey
      unbind Up
      unbind Down
      unbind Left
      unbind Right
      bind -r Left resize-pane -L    # Resize pane to the left
      bind -r Down resize-pane -D    # Resize pane downward
      bind -r Up resize-pane -U      # Resize pane upward
      bind -r Right resize-pane -R   # Resize pane to the right
      bind -r h previous-window
      bind -r l next-window
      bind -r s swap-pane -D

      # Split
      unbind %
      unbind '"'
      bind | split-window -h
      bind - split-window -v

      # Selection mode
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle \; send -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Fzf
      unbind Space
      unbind q
      bind Space popup -E -B -w80 -h10 -xC -y38.5  "fish -c pane"
      bind Escape popup -E -B -w80 -h10 -xC -y38.5  "fish -c panekill"
      bind Tab popup -E -B -w80 -h10 -xC -y38.5  "fish -c tm"
      bind q popup -E -B -w80 -h10 -xC -y38.5  "fish -c tmkill"
      bind o popup -E -B -w80 -h10 -xC -y38.5  "fish -c furl"
      bind Enter popup -E -w100 -h50 -xC -yC

      run-shell ~/.config/tmux/plugins/mythemux/mythemux.tmux
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
          set -g @vim_navigator_mapping_right "C-Right C-l"
          set -g @vim_navigator_mapping_up "C-k"
          set -g @vim_navigator_mapping_down "C-j"
          set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
  };
}
