{
  hosts,
  lib,
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.packages = lib.mkIf (hosts.hostname == "silvia") [
    pkgs.qmk
  ];
}
