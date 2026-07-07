{pkgs ? import <nixpkgs> {}, ...}: {
  seniorpw = pkgs.callPackage ./seniorpw {};
  sysboard = pkgs.callPackage ./sysboard {};
  # TODO: remove me after lock updated
  vscode-langservers-extracted-latest = pkgs.callPackage ./vscode-langservers-extracted {};
  zsh-auto-notify = pkgs.callPackage ./zsh-auto-notify {};
}
