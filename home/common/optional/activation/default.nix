{lib, ...}: let
  drunScan = import ./drun-scan.nix;
in {
  home.activation.drunScan = lib.hm.dag.entryAfter ["writeBoundary"] drunScan;
}
