{
  homes,
  lib,
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.packages = lib.mkIf homes.nchat [
    pkgs.nchat
  ];

  xdg.desktopEntries.nchat = lib.mkIf homes.nchat {
    type = "Application";
    name = "nchat";
    exec = "footclient -T nchat nchat";
    comment = "Open nchat with kitty";
  };
}
