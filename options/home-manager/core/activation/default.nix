{
  config,
  homes,
  hosts,
  lib,
  pkgs,
  ...
}: let
  theme =
    if hosts.theme == "tokyo-night-dark"
    then "tokyo-dark"
    else if hosts.theme == "catppuccin-mocha"
    then "catppuccin"
    else "palette";
  drunScan = import ./drun-scan.nix {
    inherit hosts pkgs;
  };
  resetFirefox = import ./reset-firefox.nix {
    inherit config homes hosts lib pkgs;
  };
  themeSync = import ./theme-sync.nix {
    inherit config hosts lib pkgs;
    theme = theme;
    monitor = homes.monitor;
  };
in {
  home.activation = lib.mkIf hosts.gui.enable {
    drunScan = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${drunScan}
    '';
    resetFirefox = lib.mkIf homes.firefox.enable (
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        ${resetFirefox}
      ''
    );
    themeSync = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${themeSync}
    '';
  };
}
