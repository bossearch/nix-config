{
  config,
  inputs,
  ...
}: let
  nix-colors = inputs.nix-colors;
in {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  colorScheme =
    nix-colors.lib.schemeFromYAML
    "${config.spec.theme}"
    (builtins.readFile ../../../modules/themes/${config.spec.theme}.yaml);
}
