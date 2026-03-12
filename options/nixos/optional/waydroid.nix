{
  hosts,
  pkgs,
  ...
}: {
  virtualisation.waydroid = {
    enable = hosts.waydroid;
    package = pkgs.waydroid;
  };
}
