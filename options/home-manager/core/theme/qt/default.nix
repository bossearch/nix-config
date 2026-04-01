{
  homes,
  hosts,
  lib,
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.packages = lib.mkIf hosts.gui.enable (
    with pkgs;
      [
        kdePackages.qqc2-desktop-style
        kdePackages.qt6ct
        libsForQt5.qt5ct
      ]
      ++ (lib.optionals (homes.qtstyle == "breeze") [
        kdePackages.breeze
        kdePackages.breeze.qt5
      ])
      ++ (lib.optionals (homes.qtstyle == "kvantum") [
        kdePackages.qtstyleplugin-kvantum
        libsForQt5.qtstyleplugin-kvantum
      ])
  );

  qt = {
    enable = hosts.gui.enable;
    platformTheme.name = "qtct";
  };
}
