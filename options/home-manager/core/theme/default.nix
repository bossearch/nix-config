{
  homes,
  hosts,
  pkgs,
  mylib,
  ...
}: let
  enabled = hosts.gui.enable;
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

  home.pointerCursor = {
    enable = enabled;
    name = homes.cursor;
    package = pkgsCursor;
    size = cursor;
    hyprcursor = {
      enable = enabled;
    };
  };
}
