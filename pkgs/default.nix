{pkgs ? import <nixpkgs> {}, ...}: {
  seniorpw = pkgs.callPackage ./seniorpw {};
  sysboard = pkgs.callPackage ./sysboard {};
  zsh-auto-notify = pkgs.callPackage ./zsh-auto-notify {};
  # TODO: remove me after lock updated
  vscode-langservers-extracted-latest = pkgs.callPackage ./vscode-langservers-extracted {};
  waybar-fix-hypr-lua = pkgs.callPackage ./waybar-fix-hypr-lua {};
}
