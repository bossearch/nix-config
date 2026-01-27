{pkgs ? import <nixpkgs> {}, ...}: {
  # Packages with an actual source
  seniorpw = pkgs.callPackage ./seniorpw {};
  sysboard = pkgs.callPackage ./sysboard {};
  varia = pkgs.callPackage ./varia {};
  # vaults = pkgs.callPackage ./vaults {};
  xdm = pkgs.callPackage ./xdm {};
  zsh-auto-notify = pkgs.callPackage ./zsh-auto-notify {};
}
