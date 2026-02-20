{
  homes,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./theme.nix
  ];
  home.packages = lib.mkIf homes.vesktop (with pkgs; [
    vesktop
  ]);
}
