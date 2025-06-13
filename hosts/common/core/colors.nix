{
  config,
  inputs,
  ...
}: let
  inherit (inputs.nix-colors.lib) schemeFromYAML;
  colorScheme =
    schemeFromYAML
    "${config.spec.theme}"
    (builtins.readFile ../../../modules/themes/${config.spec.theme}.yaml);
in {
  console = {
    earlySetup = true;
    colors = with colorScheme.palette; [
      base00
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
