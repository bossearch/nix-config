{
  homes,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf homes.game.playstation (with pkgs; [
    pcsx2
    rpcs3
  ]);
}
