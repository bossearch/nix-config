{
  hosts,
  mylib,
  inputs,
  ...
}: let
  themePath = mylib.at "themes/${hosts.theme}.yaml";
in {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme =
    inputs.nix-colors.lib.schemeFromYAML
    "${hosts.theme}"
    (builtins.readFile themePath);
}
