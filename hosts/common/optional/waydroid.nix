{pkgs, ...}: {
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.unstable.waydroid;
  };
}
