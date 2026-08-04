{pkgs ? import <nixpkgs> {}, ...}: {
  seniorpw = pkgs.callPackage ./seniorpw {};
  sysboard = pkgs.callPackage ./sysboard {};
  # TODO: remove me after waybar 0.16.0
  waybar-fix-hypr-lua = pkgs.callPackage ./waybar-fix-hypr-lua {};
}
