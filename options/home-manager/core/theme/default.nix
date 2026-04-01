{
  homes,
  hosts,
  lib,
  pkgs,
  mylib,
  ...
}: let
  pkgsCursor =
    if homes.cursor == "macOS"
    then pkgs.apple-cursor
    else [];
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  cursor =
    if mymonitor
    then 24
    else 22;
in {
  imports = mylib.autoimport ./.;

  home.pointerCursor = lib.mkIf hosts.gui.enable {
    name = homes.cursor;
    package = pkgsCursor;
    hyprcursor = lib.mkIf (hosts.gui.windowmanager == "hyprland") {
      enable = true;
      size = cursor;
    };
  };
}
