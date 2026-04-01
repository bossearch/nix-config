{
  config,
  homes,
  hosts,
  lib,
  mylib,
  ...
}: let
  qtstyle =
    if homes.qtstyle == "breeze"
    then "Breeze"
    else if homes.qtstyle == "kvantum"
    then "kvantum-dark"
    else "Fusion";
  qtct = {
    Appearance = {
      custom_palette = true;
      icon_theme = homes.icon;
      standard_dialogs = "default";
      style = "${qtstyle}";
    };
    Fonts = {
      fixed = "\"${homes.nerdfont} Nerd Font,10\"";
      general = "\"${homes.nerdfont} Nerd Font,10\"";
    };
  };
in {
  imports = mylib.autoimport ./.;

  qt = lib.mkIf hosts.gui.enable {
    qt5ctSettings =
      qtct
      // {
        Appearance =
          qtct.Appearance
          // {
            color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/colors.conf";
          };
      };
    qt6ctSettings =
      qtct
      // {
        Appearance =
          qtct.Appearance
          // {
            color_scheme_path = "${config.xdg.configHome}/qt6ct/colors/colors.conf";
          };
      };
  };
}
