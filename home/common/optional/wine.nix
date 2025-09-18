{pkgs, ...}: let
  bottles = pkgs.unstable.bottles.override {
    removeWarningPopup = true;
  };
in {
  home.packages = with pkgs; [
    bottles
    wineWowPackages.staging
    winetricks
  ];
  programs.lutris = {
    enable = true;
  };
}
