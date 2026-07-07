{
  homes,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf homes.kdenlive (with pkgs; [
    kdePackages.kdenlive
  ]);
}
