{
  hosts,
  lib,
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.packages = lib.mkIf hosts.udevqmk [
    pkgs.qmk
  ];
}
