{
  hosts,
  mylib,
  inputs,
  ...
}: let
  themePath = mylib.at "themes/${hosts.theme}.yaml";
  nix-colors = inputs.nix-colors;
in {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  colorScheme =
    nix-colors.lib.schemeFromYAML
    "${hosts.theme}"
    (builtins.readFile themePath);
}
