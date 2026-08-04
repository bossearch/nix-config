{pkgs ? import <nixpkgs> {}, ...}: {
  seniorpw = pkgs.callPackage ./seniorpw {};
  sysboard = pkgs.callPackage ./sysboard {};
  zsh-auto-notify = pkgs.callPackage ./zsh-auto-notify {};
  # TODO: remove me after waybar 0.16.0
  waybar-fix-hypr-lua = pkgs.callPackage ./waybar-fix-hypr-lua {};
}
