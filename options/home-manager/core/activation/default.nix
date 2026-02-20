{
  homes,
  hosts,
  lib,
  ...
}: let
  theme =
    if hosts.theme == "tokyo-night-dark"
    then "tokyo-dark"
    else if hosts.theme == "catppuccin-mocha"
    then "catppuccin"
    else "palette";
  drunScan = import ./drun-scan.nix {
    inherit hosts;
  };
  themeSync = import ./theme-sync.nix {
    inherit hosts;
    inherit lib;
    theme = theme;
    monitor = homes.monitor;
  };
in {
  home.activation = lib.mkIf hosts.gui.enable {
    drunScan = lib.hm.dag.entryAfter ["writeBoundary"] drunScan;
    themeSync = lib.hm.dag.entryAfter ["writeBoundary"] themeSync;
  };
}
