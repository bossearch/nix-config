{
  homes,
  pkgs,
  ...
}: {
  services.kdeconnect = {
    enable = homes.kdeconnect;
    indicator = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };
}
