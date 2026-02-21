{
  hosts,
  lib,
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.packages = lib.mkIf hosts.gui.enable (with pkgs; [
    mangohud
  ]);
}
