{
  homes,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf homes.libreoffice (with pkgs; [
    libreoffice
  ]);
}
