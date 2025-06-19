{pkgs, ...}: {
  imports = [
    ./gtk
    ./qt
  ];
  home.packages = with pkgs; [
    adw-gtk3
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
  ];
  home.pointerCursor = {
    name = "macOS";
    package = pkgs.apple-cursor;
  };

  xdg.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
    };
    cursorTheme = {
      name = "macOS";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };
}
