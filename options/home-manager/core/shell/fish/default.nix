{
  config,
  homes,
  hosts,
  pkgs,
  ...
}: let
  init-tmux =
    if hosts.gui.enable
    then "bash ~/.config/fish/init-tmux.sh"
    else "";
  kittyfish = homes.kitty && hosts.shell == "fish";
in {
  imports = [
    ./completions.nix
    ./fzf_complete.nix
    ./starship.nix
  ];
  programs.fish = {
    enable = hosts.shell == "fish";
    generateCompletions = false;
    interactiveShellInit = ''
      ${init-tmux}
      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
      fish_default_key_bindings

      functions --query notify
      functions --query savecmd
      functions --query ignore_history


      bind \t '__fzf_complete'
      bind ! __fish_expand_bang
      bind . __fish_expand_dots
      bind '$' __fish_expand_args
      bind \cz 'jobs -q; and fg >/dev/null 2>&1; commandline -f repaint'

      set -gx AGE_KEY_FILE "${config.sops.age.keyFile}"
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
      ls = "eza --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions";
      mv = "mv -i";
      rm = "rm -i";
      cp = "cp -i";
      c = "clear";
      cat = "bat --style=plain";
      bridge-enable = "nmcli con up br0";
      bridge-disable = "nmcli con down br0";
      gh-create = "gh repo create --private --source=. --remote=origin && git push -u --all && gh browse";
      nyaa = "setsid --fork transmission-gtk >/dev/null 2>&1 </dev/null; command nyaa $argv";
      z = "zoxide";
      lg = "lazygit";
    };
    functions = import ./.functions;
  };
  programs.kitty.shellIntegration = {
    enableFishIntegration = kittyfish;
  };
}
