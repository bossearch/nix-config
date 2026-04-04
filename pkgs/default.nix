{pkgs ? import <nixpkgs> {}, ...}: {
  seniorpw = pkgs.callPackage ./seniorpw {};
  sysboard = pkgs.callPackage ./sysboard {};
  zsh-auto-notify = pkgs.callPackage ./zsh-auto-notify {};
}
