{
  hosts,
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
    "${hosts.theme}"
    (builtins.readFile ../../../themes/${hosts.theme}.yaml);
}
