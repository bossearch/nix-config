{
  config,
  hosts,
  lib,
  inputs,
  ...
}: let
  nix-colors = inputs.nix-colors;
  toRGBString = nix-colors.lib.conversions.hexToRGBString ",";
  base00 = "${toRGBString config.colorScheme.palette.base00}";
  base01 = "${toRGBString config.colorScheme.palette.base01}";
  base02 = "${toRGBString config.colorScheme.palette.base02}";
  base03 = "${toRGBString config.colorScheme.palette.base03}";
  base04 = "${toRGBString config.colorScheme.palette.base04}";
  base05 = "${toRGBString config.colorScheme.palette.base05}";
  base07 = "${toRGBString config.colorScheme.palette.base07}";
  base08 = "${toRGBString config.colorScheme.palette.base08}";
  base09 = "${toRGBString config.colorScheme.palette.base09}";
  base0A = "${toRGBString config.colorScheme.palette.base0A}";
  base0B = "${toRGBString config.colorScheme.palette.base0B}";
  base0C = "${toRGBString config.colorScheme.palette.base0C}";
  base0D = "${toRGBString config.colorScheme.palette.base0D}";
  base0E = "${toRGBString config.colorScheme.palette.base0E}";
in {
  home.file.".config/kdeglobals" = lib.mkIf hosts.gui.enable {
    text = ''
      [ColorEffects:Disabled]
      Color=${base03}
      ColorAmount=0.15
      ColorEffect=2
      ContrastAmount=0.8
      ContrastEffect=1
      IntensityAmount=-1
      IntensityEffect=2

      [ColorEffects:Inactive]
      ChangeSelectionColor=true
      Color=${base01}
      ColorAmount=0.025
      ColorEffect=2
      ContrastAmount=0.1
      ContrastEffect=2
      Enable=false
      IntensityAmount=0
      IntensityEffect=0

      [Colors:Button]
      BackgroundAlternate=${base02}
      BackgroundNormal=${base01}
      DecorationFocus=${base0D}
      DecorationHover=${base0D}
      ForegroundActive=${base0D}
      ForegroundInactive=${base04}
      ForegroundLink=${base0C}
      ForegroundNegative=${base08}
      ForegroundNeutral=${base0A}
      ForegroundNormal=${base05}
      ForegroundPositive=${base0B}
      ForegroundVisited=${base0E}

      [Colors:Complementary]
      BackgroundAlternate=${base02}
      BackgroundNormal=${base01}
      DecorationFocus=${base0D}
      DecorationHover=${base0D}
      ForegroundActive=${base0D}
      ForegroundInactive=${base04}
      ForegroundLink=${base0C}
      ForegroundNegative=${base08}
      ForegroundNeutral=${base0A}
      ForegroundNormal=${base05}
      ForegroundPositive=${base0B}
      ForegroundVisited=${base0E}

      [Colors:Header]
      BackgroundAlternate=${base01}
      BackgroundNormal=${base00}
      DecorationFocus=${base0D}
      DecorationHover=${base0D}
      ForegroundActive=${base0D}
      ForegroundInactive=${base04}
      ForegroundLink=${base0C}
      ForegroundNegative=${base08}
      ForegroundNeutral=${base0A}
      ForegroundNormal=${base05}
      ForegroundPositive=${base0B}
      ForegroundVisited=${base0E}

      [Colors:Header][Inactive]
      BackgroundAlternate=${base01}
      BackgroundNormal=${base00}
      DecorationFocus=${base03}
      DecorationHover=${base03}
      ForegroundActive=${base03}
      ForegroundInactive=${base04}
      ForegroundLink=${base0D}
      ForegroundNegative=${base08}
      ForegroundNeutral=${base0A}
      ForegroundNormal=${base04}
      ForegroundPositive=${base0B}
      ForegroundVisited=${base0E}

      [Colors:Selection]
      BackgroundAlternate=${base0D}
      BackgroundNormal=${base02}
      DecorationFocus=${base00}
      DecorationHover=${base00}
      ForegroundActive=${base07}
      ForegroundInactive=${base04}
      ForegroundLink=${base0D}
      ForegroundNegative=${base08}
      ForegroundNeutral=${base09}
      ForegroundNormal=${base05}
      ForegroundPositive=${base0B}
      ForegroundVisited=${base0E}

      [Colors:Tooltip]
      BackgroundAlternate=${base01}
      BackgroundNormal=${base00}
      DecorationFocus=${base0D}
      DecorationHover=${base0D}
      ForegroundActive=${base0D}
      ForegroundInactive=${base04}
      ForegroundLink=${base0C}
      ForegroundNegative=${base08}
      ForegroundNeutral=${base0A}
      ForegroundNormal=${base05}
      ForegroundPositive=${base0B}
      ForegroundVisited=${base0E}

      [Colors:View]
      BackgroundAlternate=${base01}
      BackgroundNormal=${base00}
      DecorationFocus=${base0D}
      DecorationHover=${base0D}
      ForegroundActive=${base0D}
      ForegroundInactive=${base04}
      ForegroundLink=${base0C}
      ForegroundNegative=${base08}
      ForegroundNeutral=${base0A}
      ForegroundNormal=${base05}
      ForegroundPositive=${base0B}
      ForegroundVisited=${base0E}

      [Colors:Window]
      BackgroundAlternate=${base01}
      BackgroundNormal=${base00}
      DecorationFocus=${base0D}
      DecorationHover=${base0D}
      ForegroundActive=${base0D}
      ForegroundInactive=${base04}
      ForegroundLink=${base0C}
      ForegroundNegative=${base08}
      ForegroundNeutral=${base0A}
      ForegroundNormal=${base05}
      ForegroundPositive=${base0B}
      ForegroundVisited=${base0E}

      [General]
      ColorScheme=colors
      Name=colors
      shadeSortColumn=true

      [KDE]
      contrast=4

      [WM]
      activeBackground=${base00}
      activeBlend=${base05}
      activeForeground=${base05}
      inactiveBackground=${base01}
      inactiveBlend=${base04}
      inactiveForeground=${base04}
    '';
  };
}
