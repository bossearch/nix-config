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
    # ../common/core/colors.nix
    ../common/core/shell
    ../common/core/cli/fastfetch
    ../common/core/cli/fzf
    ../common/core/cli/lazygit
    ../common/core/cli/tealdeer
    # ../common/core/cli/yazi
  ];

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "ansi";
    };
  };

  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };

  # Do not change these future me !
  home.stateVersion = "24.05";
}
