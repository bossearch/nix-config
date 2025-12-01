{
  config,
  inputs,
  pkgs,
  ...
}: let
  base00 = config.colorScheme.palette.base00;
  base02 = config.colorScheme.palette.base02;
  base05 = config.colorScheme.palette.base05;
  base07 = config.colorScheme.palette.base07;
  base08 = config.colorScheme.palette.base08;
  base0B = config.colorScheme.palette.base0B;
  base0D = config.colorScheme.palette.base0D;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblockify
    ];

    theme = spicePkgs.themes.text;
    customColorScheme = {
      accent = base0B;
      accent-active = base0B;
      accent-inactive = base00;
      banner = base0B;
      border-active = base0B;
      border-inactive = base02;
      header = base07;
      highlight = base02;
      main = base00;
      notification = base0D;
      notification-error = base08;
      subtext = base07;
      text = base05;
    };
  };
}
