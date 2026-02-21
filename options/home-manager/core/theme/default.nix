{
  homes,
  hosts,
  lib,
  pkgs,
  mylib,
  ...
}: let
  pkgsCursor =
    if homes.cursor == "macOS"
    then pkgs.apple-cursor
    else [];
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  cursor =
    if mymonitor
    then 24
    else 22;
in {
  imports = mylib.autoimport ./.;

  home = lib.mkIf hosts.gui.enable {
    packages = with pkgs; [
      adw-gtk3
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];
    pointerCursor = {
      name = homes.cursor;
      package = pkgsCursor;
      hyprcursor = lib.mkIf (hosts.gui.windowmanager == "hyprland") {
        enable = true;
        size = cursor;
      };
    };
  };

  xdg.enable = hosts.gui.enable;

  gtk = {
    enable = hosts.gui.enable;
    theme = {
      name = "adw-gtk3";
    };
    cursorTheme = {
      name = homes.cursor;
    };
    iconTheme = {
      name = homes.icon;
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = hosts.gui.enable;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };
}
