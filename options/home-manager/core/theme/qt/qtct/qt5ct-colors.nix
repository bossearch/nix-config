{
  config,
  hosts,
  lib,
  ...
}: let
  c = lib.mapAttrs (name: value: "#ff${value}") config.colorScheme.palette;
  active = [
    c.base07
    c.base01
    c.base02
    c.base03
    c.base04
    c.base02
    c.base07
    "#ffffffff"
    c.base07
    c.base00
    c.base00
    c.base03
    c.base0D
    c.base00
    c.base0D
    c.base0E
    c.base01
    "#ff000000"
    c.base06
    c.base00
    c.base0D
  ];

  disabled = [
    c.base04
    c.base01
    c.base02
    c.base03
    c.base04
    c.base02
    c.base04
    "#ffffffff"
    c.base04
    c.base00
    c.base00
    c.base01
    c.base03
    c.base00
    c.base0D
    c.base0E
    c.base00
    "#ff000000"
    c.base00
    c.base04
    c.base03
  ];
in {
  home.file.".config/qt5ct/colors/colors.conf" = lib.mkIf hosts.gui.enable {
    text = ''
      [ColorScheme]
      active_colors=${lib.concatStringsSep ", " active}
      disabled_colors=${lib.concatStringsSep ", " disabled}
      inactive_colors=${lib.concatStringsSep ", " active}
    '';
  };
}
