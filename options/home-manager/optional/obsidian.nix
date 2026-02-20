{
  homes,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf homes.obsidian (with pkgs; [
    obsidian
  ]);
}
