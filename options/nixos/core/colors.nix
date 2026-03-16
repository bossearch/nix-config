{
  hosts,
  inputs,
  mylib,
  ...
}: let
  inherit (inputs.nix-colors.lib) schemeFromYAML;
  themePath = mylib.at "themes/${hosts.theme}.yaml";
  colorScheme =
    schemeFromYAML
    "${hosts.theme}"
    (builtins.readFile themePath);
in {
  console = {
    earlySetup = true;
    colors = with colorScheme.palette; [
      base01
      base08
      base0B
      base0A
      base0D
      base0E
      base0C
      base05
      base03
      base08
      base0B
      base0A
      base0D
      base0E
      base0C
      base07
    ];
  };
}
