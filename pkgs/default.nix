{pkgs ? import <nixpkgs> {}, ...}: {
  # Packages with an actual source
  sysboard = pkgs.callPackage ./sysboard {};
  varia = pkgs.callPackage ./varia {};
  zsh-auto-notify = pkgs.callPackage ./zsh-auto-notify {};
}
