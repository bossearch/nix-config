{
  config,
  homes,
  hosts,
  lib,
  pkgs,
  ...
}: let
  nvimConfigType = homes.neovim; # either `lua` or `nix`
  nvimConfig = import ./nvim-config.nix {inherit pkgs;};
  drunScan = import ./drun-scan.nix {
    inherit hosts pkgs;
  };
  resetFirefox = import ./reset-firefox.nix {
    inherit config homes hosts lib pkgs;
  };
  theme =
    if hosts.theme == "tokyo-night-dark"
    then "tokyo-dark"
    else if hosts.theme == "catppuccin-mocha"
    then "catppuccin"
    else "palette";
  themeSync = import ./theme-sync.nix {
    inherit config hosts lib pkgs;
    theme = theme;
    monitor = homes.monitor;
  };
in {
  home.activation = lib.mkIf hosts.gui.enable {
    rmNvimConfig = (
      lib.hm.dag.entryBefore ["writeBoundary"] ''
        ${nvimConfig} ${nvimConfigType}
      ''
    );
    cloneNvimConfig = lib.mkIf config.programs.neovim.enable (
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        ${nvimConfig} clone
      ''
    );
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
