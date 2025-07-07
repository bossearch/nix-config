{
  config,
  lib,
  ...
}: let
  theme =
    if config.spec.theme == "tokyo-night-dark"
    then "tokyo-dark"
    else if config.spec.theme == "catppuccin-mocha"
    then "catppuccin"
    else "palette";
  drunScan = import ./drun-scan.nix {
    inherit config;
  };
  themeSync = import ./theme-sync.nix {
    inherit config;
    inherit lib;
    theme = theme;
    monitors = config.monitors;
  };
in {
  home.activation = {
    drunScan = lib.hm.dag.entryAfter ["writeBoundary"] drunScan;
    themeSync = lib.hm.dag.entryAfter ["writeBoundary"] themeSync;
  };
}
