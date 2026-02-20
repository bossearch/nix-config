{
  hosts,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./lsfg.nix
    ./lutris.nix
    ./minecraft.nix
  ];

  home.packages = lib.mkIf hosts.gui.enable (with pkgs; [
    mangohud
  ]);
}
