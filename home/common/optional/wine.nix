{pkgs, ...}: let
  bottles = pkgs.unstable.bottles.override {
    removeWarningPopup = true;
  };
in {
  home.packages = [
    bottles
  ];
  programs.lutris = {
    enable = true;
    package = pkgs.lutris;
    extraPackages = with pkgs; [winetricks];
    winePackages = with pkgs; [wineWow64Packages.waylandFull];
  };
}
