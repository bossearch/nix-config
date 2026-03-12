{
  config,
  homes,
  hosts,
  lib,
  ...
}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
  base00 = config.colorScheme.palette.base00;
  base01 = config.colorScheme.palette.base01;
  base06 = config.colorScheme.palette.base06;
  base07 = config.colorScheme.palette.base07;
  base0F = config.colorScheme.palette.base0F;
in {
  home.file.".config/hypr/hyprtoolkit.conf" = lib.mkIf enabled {
    text = ''
      background = 0xFF${base01}
      base = 0xFF${base00}
      text = 0xFF${base07}
      alternate_base = 0xFF${base00}
      bright_text = 0xFF${base06}
      accent = 0xFF${base0F}
      accent_secondary = 0xFF${base0F}
      font_family = Noto Sans
      font_family_monospace = ${homes.nerdfont} Nerd Font Mono
      h1_size = 18
      h2_size = 16
      h3_size = 14
      font_size = 12
      small_font_size = 10
      rounding_large = 8
      rounding_small = 8
    '';
  };
}
