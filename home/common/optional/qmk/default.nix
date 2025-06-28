{pkgs, ...}: {
  imports = [
    ./assets
  ];
  home.packages = [
    pkgs.unstable.qmk
  ];
}
