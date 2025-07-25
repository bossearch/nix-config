{inputs, ...}: let
  nix-colors = inputs.nix-colors;
  theme = "tokyo-night-dark";
in {
  colorScheme =
    nix-colors.lib.schemeFromYAML
    theme
    (builtins.readFile ../../modules/themes/${theme}.yaml);

  imports = [
    nix-colors.homeManagerModules.default
    ../common/core/shell
    ../common/core/cli/fastfetch
    ../common/core/cli/fzf
    ../common/core/cli/lazygit
    ../common/core/cli/tealdeer
    ../common/core/cli/yazi
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "ansi";
      };
    };
    eza.enable = true;
    fish = {
      shellInit = ''
        set -gx lamp_ip 192.168.18.14
        set -gx port 38899
      '';
      shellAliases = {
        on = ''
          echo -n "{\"id\":1,\"method\":\"setState\",\"params\":{\"state\":true}}" | socat - UDP:$lamp_ip:$port'';
        off = ''
          echo -n "{\"id\":1,\"method\":\"setState\",\"params\":{\"state\":false}}" | socat - UDP:$lamp_ip:$port'';
        clear = ''
          printf "\033c"'';
      };
      shellAbbrs = {
        droid = "cd /storage/emulated/0";
        sandisk = "cd /mnt/media_rw/A540_AC71";
      };
    };
    zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };
  };

  # Do not change these future me !
  home.stateVersion = "24.05";
}
