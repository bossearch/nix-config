{pkgs ? import <nixpkgs> {}, ...}: {
  seniorpw = pkgs.callPackage ./seniorpw {};
  sysboard = pkgs.callPackage ./sysboard {};
  xdm = pkgs.callPackage ./xdm {};
  zsh-auto-notify = pkgs.callPackage ./zsh-auto-notify {};
}
