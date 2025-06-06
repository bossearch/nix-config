{pkgs ? import <nixpkgs> {}, ...}: {
  # Packages with an actual source
  sysboard = pkgs.callPackage ./sysboard {};
  varia = pkgs.callPackage ./varia {};
  vaults = pkgs.callPackage ./vaults {};
  zsh-auto-notify = pkgs.callPackage ./zsh-auto-notify {};
}
