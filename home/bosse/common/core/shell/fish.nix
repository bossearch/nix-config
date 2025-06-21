{pkgs, ...}: {
  imports = [
    ./starship.nix
    ./functions/fish/fzf_complete.nix
    ./functions/fish/completions.nix
  ];
  programs.fish = {
    enable = true;
    shellInit = ''
      set -gx FZF_CTRL_T_OPTS "--preview='~/.config/fzf/extra/fzf-preview.sh {}'"
      set -gx FZF_ALT_C_OPTS  "--preview='~/.config/fzf/extra/fzf-preview.sh {}'";
      set -gx FZF_PREVIEW_FILE_CMD "bat --color=always --style=plain --theme=ansi"
      set -gx FZF_PREVIEW_DIR_CMD "eza -1 --tree --level=2 --all --icons=always --color=always"
    '';
    interactiveShellInit = ''
      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
      fish_vi_key_bindings
      functions --query notify
      functions --query savecmd
      bind -M insert \t '__fzf_complete'
      bind -M insert ! __fish_expand_bang
      bind -M insert . __fish_expand_dots
      bind -M insert '$' __fish_expand_args
      bind -M default --erase ! . '$'

      set -gx fish_color_autosuggestion      brblack
      set -gx fish_color_cancel              -r
      set -gx fish_color_command             green
      set -gx fish_color_comment             magenta
      set -gx fish_color_cwd                 green
      set -gx fish_color_cwd_root            red
      set -gx fish_color_end                 magenta
      set -gx fish_color_error               red
      set -gx fish_color_escape              cyan
      set -gx fish_color_history_current     --bold
      set -gx fish_color_host                normal
      set -gx fish_color_host_remote         yellow
      set -gx fish_color_match               --background=blue
      set -gx fish_color_normal              normal
      set -gx fish_color_operator            cyan
      set -gx fish_color_param               blue
      set -gx fish_color_quote               yellow
      set -gx fish_color_redirection         yellow
      set -gx fish_color_search_match        'yellow' '--background=brblack'
      set -gx fish_color_selection           'white' '--bold' '--background=black'
      set -gx fish_color_status              red
      set -gx fish_color_user                green
      set -gx fish_color_valid_path          --underline
      set -gx fish_pager_color_completion    normal
      set -gx fish_pager_color_description   yellow
      set -gx fish_pager_color_prefix        'white' '--bold' '--underline'
      set -gx fish_pager_color_progress      'white' '--background=cyan'
    '';
    shellAliases = {
      v = "nvim --startuptime /tmp/nvim-startup.log";
      vi = "nvim --startuptime /tmp/nvim-startup.log";
      vim = "nvim --startuptime /tmp/nvim-startup.log";
      nvim = "nvim --startuptime /tmp/nvim-startup.log";
      ls = "eza -l --color=always --no-user --no-permissions --no-filesize --no-time";
      la = "eza -la --color=always --no-user --no-permissions --no-filesize --no-time";
      ll = "eza -aloh --color=always --long";
      lt = "eza -T";
      mv = "mv -i";
      rm = "rm -i";
      cp = "cp -i";
      c = "clear";
      cat = "bat --style=plain --theme=ansi";
      ".." = "cd ..";
      gh-create = "gh repo create --private --source=. --remote=origin && git push -u --all && gh browse";
    };
    functions = import ./functions/fish;
  };
  programs.kitty.shellIntegration = {
    enableFishIntegration = true;
  };
  programs.zoxide.enableFishIntegration = true;
  programs.fzf.enableFishIntegration = true;
}
