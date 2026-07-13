{
  config,
  inputs,
  ...
}: let
  hexToRGB = inputs.nix-colors.lib.conversions.hexToRGB;

  blendChannels = c1: c2: weight: let
    mixed = (c1 * weight) + (c2 * (1.0 - weight));
    rounded = builtins.floor (mixed + 0.5);
  in
    if rounded > 255
    then 255
    else if rounded < 0
    then 0
    else rounded;

  decToHexStr = dec: let
    hexChars = "0123456789abcdef";
    high = builtins.substring (dec / 16) 1 hexChars;
    low = builtins.substring (dec - (dec / 16) * 16) 1 hexChars;
  in "${high}${low}";

  blend = fgHex: bgHex: weight: let
    fgRgb = hexToRGB fgHex;
    bgRgb = hexToRGB bgHex;

    r = blendChannels (builtins.elemAt fgRgb 0) (builtins.elemAt bgRgb 0) weight;
    g = blendChannels (builtins.elemAt fgRgb 1) (builtins.elemAt bgRgb 1) weight;
    b = blendChannels (builtins.elemAt fgRgb 2) (builtins.elemAt bgRgb 2) weight;
  in "#${decToHexStr r}${decToHexStr g}${decToHexStr b}";

  base00 = config.colorScheme.palette.base00;
  base01 = config.colorScheme.palette.base01;
  base02 = config.colorScheme.palette.base02;
  base03 = config.colorScheme.palette.base03;
  base07 = config.colorScheme.palette.base07;
  base08 = config.colorScheme.palette.base08;
  base0B = config.colorScheme.palette.base0B;
  base0F = config.colorScheme.palette.base0F;

  softRed = blend base08 base01 0.1;
  softGreen = blend base0B base01 0.1;
  hardRed = blend base08 base01 0.5;
  hardGreen = blend base0B base01 0.5;
in {
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      syntax-theme = "my-base16"; # custom theme from bat
      side-by-side = false;
      navigate = true;
      file-modified-label = "modified:";
      right-arrow = "󰛂";

      line-numbers = true;
      line-numbers-left-format = "{nm:>3} ";
      line-numbers-right-format = "{np:>3} ";
      line-numbers-minus-style = "#${base08}";
      line-numbers-plus-style = "#${base0B}";
      line-numbers-zero-style = "#${base03}";
      line-numbers-left-style = "#${base0F}";
      line-numbers-right-style = "#${base0F}";

      minus-style = "syntax ${softRed}";
      plus-style = "syntax ${softGreen}";
      minus-emph-style = "syntax ${hardRed}";
      plus-emph-style = "syntax ${hardGreen}";
      minus-empty-line-marker-style = "normal ${hardRed}";
      plus-empty-line-marker-style = "normal ${hardGreen}";

      blame-palette = "#${base00} #${base02} #${base03}";
      inline-hint-style = "#${base0F}";
      file-style = "#${base07}";
      file-decoration-style = "";

      # disable hunk
      hunk-header-style = "omit"; # default = "line-number syntax"
    };
  };
}
