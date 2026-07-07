{
  config,
  homes,
  ...
}: let
  theme = "base16";
in {
  programs.opencode = {
    enable = homes.ai.opencode;
    extraPackages = [];
    commands = {};
    tui = {inherit theme;};
    themes.${theme} = import ./theme.nix {inherit config;};
  };
}
