{inputs, ...}: let
  nix-colors = inputs.nix-colors;
in {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  colorScheme =
    nix-colors.lib.schemeFromYAML
    "tokyo-night-terminal-dark"
    (builtins.readFile ../../../../modules/themes/tokyo-night-dark.yaml);
}
