{
  homes,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf homes.game.pcsx2 (with pkgs; [
    pcsx2
  ]);
}
