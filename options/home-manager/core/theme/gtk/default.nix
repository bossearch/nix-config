{
  homes,
  hosts,
  lib,
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.packages = lib.mkIf hosts.gui.enable (with pkgs; [
    adw-gtk3
  ]);

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
}
