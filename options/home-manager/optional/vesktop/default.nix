{
  homes,
  lib,
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.packages = lib.mkIf homes.vesktop (with pkgs; [
    vesktop
  ]);
}
