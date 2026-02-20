{
  homes,
  lib,
  pkgs,
  ...
}: {
  imports = [./conf];

  home.packages = lib.mkIf homes.nchat [
    pkgs.unstable.nchat
  ];

  xdg.desktopEntries.nchat = lib.mkIf homes.nchat {
    type = "Application";
    name = "nchat";
    exec = "kitty -T nchat nchat";
    comment = "Open nchat with kitty";
  };
}
