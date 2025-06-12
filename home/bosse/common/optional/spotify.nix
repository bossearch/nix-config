{
  config,
  inputs,
  pkgs,
  ...
}: let
  base00 = config.lib.stylix.colors.base00;
  base02 = config.lib.stylix.colors.base02;
  base05 = config.lib.stylix.colors.base05;
  base07 = config.lib.stylix.colors.base07;
  base08 = config.lib.stylix.colors.base08;
  base0B = config.lib.stylix.colors.base0B;
  base0D = config.lib.stylix.colors.base0D;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
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
