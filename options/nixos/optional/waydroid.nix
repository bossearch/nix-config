{
  config,
  pkgs,
  ...
}: {
  virtualisation.waydroid = {
    enable = config.spec.waydroid;
    package = pkgs.unstable.waydroid;
  };
}
