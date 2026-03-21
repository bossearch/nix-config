{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  quickshell = with pkgs;
    inputs.quickshell.packages.${system}.default.withModules [
      kdePackages.qtsvg
      libsForQt5.qt5.qtwayland
      kdePackages.qtwayland
      kdePackages.qt5compat
    ];
in {
  programs.quickshell = {
    enable = true;
    package = quickshell;
  };
}
