{
  config,
  hosts,
  lib,
  inputs,
  ...
}: let
  nix-colors = inputs.nix-colors;
  toRGBString = nix-colors.lib.conversions.hexToRGBString ",";
  base00-rgb = "${toRGBString config.colorScheme.palette.base00}";
  base01-rgb = "${toRGBString config.colorScheme.palette.base01}";
  base03-rgb = "${toRGBString config.colorScheme.palette.base03}";
  base04-rgb = "${toRGBString config.colorScheme.palette.base04}";
  base05-rgb = "${toRGBString config.colorScheme.palette.base05}";
  base07-rgb = "${toRGBString config.colorScheme.palette.base07}";
  base08-rgb = "${toRGBString config.colorScheme.palette.base08}";
  base09-rgb = "${toRGBString config.colorScheme.palette.base09}";
  base0B-rgb = "${toRGBString config.colorScheme.palette.base0B}";
  base0C-rgb = "${toRGBString config.colorScheme.palette.base0C}";
  base0D-rgb = "${toRGBString config.colorScheme.palette.base0D}";
  base0F-rgb = "${toRGBString config.colorScheme.palette.base0F}";
in {
  home.file.".config/kdeglobals" = lib.mkIf hosts.gui.enable {
    text = ''
      [ColorEffects:Disabled]
      ChangeSelectionColor=
      Color=${base04-rgb}
      ColorAmount=0
      ColorEffect=0
      ContrastAmount=0.65
      ContrastEffect=1
      Enable=
      IntensityAmount=0.1
      IntensityEffect=2

      [ColorEffects:Inactive]
      ChangeSelectionColor=true
      Color=${base04-rgb}
      ColorAmount=0.025
      ColorEffect=2
      ContrastAmount=0.1
      ContrastEffect=2
      Enable=false
      IntensityAmount=0
      IntensityEffect=0

      [Colors:Button]
      BackgroundAlternate=${base03-rgb}
      BackgroundNormal=${base04-rgb}
      DecorationFocus=${base0D-rgb}
      DecorationHover=${base0D-rgb}
      ForegroundActive=${base0D-rgb}
      ForegroundInactive=${base07-rgb},100
      ForegroundLink=${base0D-rgb}
      ForegroundNegative=${base08-rgb}
      ForegroundNeutral=${base09-rgb}
      ForegroundNormal=${base07-rgb}
      ForegroundPositive=${base0B-rgb}
      ForegroundVisited=${base0F-rgb}

      [Colors:Complementary]
      BackgroundAlternate=${base00-rgb}
      BackgroundNormal=${base01-rgb}
      DecorationFocus=${base0D-rgb}
      DecorationHover=${base0D-rgb}
      ForegroundActive=${base0D-rgb}
      ForegroundInactive=${base07-rgb}
      ForegroundLink=${base0D-rgb}
      ForegroundNegative=${base08-rgb}
      ForegroundNeutral=${base09-rgb}
      ForegroundNormal=${base07-rgb}
      ForegroundPositive=${base0B-rgb}
      ForegroundVisited=${base0F-rgb}

      [Colors:Header]
      BackgroundAlternate=${base00-rgb}
      BackgroundNormal=${base01-rgb}
      DecorationFocus=${base0D-rgb}
      DecorationHover=${base0D-rgb}
      ForegroundActive=${base0D-rgb}
      ForegroundInactive=${base07-rgb}
      ForegroundLink=${base0D-rgb}
      ForegroundNegative=${base08-rgb}
      ForegroundNeutral=${base09-rgb}
      ForegroundNormal=${base07-rgb}
      ForegroundPositive=${base0B-rgb}
      ForegroundVisited=${base0F-rgb}

      [Colors:Header][Inactive]
      BackgroundAlternate=${base00-rgb}
      BackgroundNormal=${base01-rgb}
      DecorationFocus=${base0D-rgb}
      DecorationHover=${base0C-rgb}
      ForegroundActive=${base0C-rgb}
      ForegroundInactive=${base07-rgb},70
      ForegroundLink=${base0D-rgb}
      ForegroundNegative=${base08-rgb}
      ForegroundNeutral=${base09-rgb}
      ForegroundNormal=${base07-rgb},150
      ForegroundPositive=${base0B-rgb}
      ForegroundVisited=${base0F-rgb}

      [Colors:Selection]
      BackgroundAlternate=${base03-rgb}
      BackgroundNormal=${base04-rgb}
      DecorationFocus=${base0D-rgb}
      DecorationHover=${base0D-rgb}
      ForegroundActive=${base0D-rgb}
      ForegroundInactive=${base07-rgb}
      ForegroundLink=${base0D-rgb}
      ForegroundNegative=${base08-rgb}
      ForegroundNeutral=${base09-rgb}
      ForegroundNormal=${base07-rgb}
      ForegroundPositive=${base0B-rgb}
      ForegroundVisited=${base05-rgb}

      [Colors:Tooltip]
      BackgroundAlternate=${base01-rgb}
      BackgroundNormal=${base01-rgb}
      DecorationFocus=${base0D-rgb}
      DecorationHover=${base0D-rgb}
      ForegroundActive=${base0D-rgb}
      ForegroundInactive=${base07-rgb},150
      ForegroundLink=${base0D-rgb}
      ForegroundNegative=${base08-rgb}
      ForegroundNeutral=${base09-rgb}
      ForegroundNormal=${base07-rgb}
      ForegroundPositive=${base0B-rgb}
      ForegroundVisited=${base0F-rgb}

      [Colors:View]
      BackgroundAlternate=${base00-rgb}
      BackgroundNormal=${base00-rgb}
      DecorationFocus=${base0D-rgb}
      DecorationHover=${base0D-rgb}
      ForegroundActive=${base0D-rgb}
      ForegroundInactive=${base07-rgb},100
      ForegroundLink=${base0D-rgb}
      ForegroundNegative=${base08-rgb}
      ForegroundNeutral=${base09-rgb}
      ForegroundNormal=${base07-rgb}
      ForegroundPositive=${base0B-rgb}
      ForegroundVisited=${base0F-rgb}

      [Colors:Window]
      BackgroundAlternate=${base00-rgb}
      BackgroundNormal=${base01-rgb}
      DecorationFocus=${base0D-rgb}
      DecorationHover=${base0D-rgb}
      ForegroundActive=${base0D-rgb}
      ForegroundInactive=${base07-rgb},100
      ForegroundLink=${base0D-rgb}
      ForegroundNegative=${base08-rgb}
      ForegroundNeutral=${base09-rgb}
      ForegroundNormal=${base07-rgb}
      ForegroundPositive=${base0B-rgb}
      ForegroundVisited=${base0F-rgb}
    '';
  };
}
