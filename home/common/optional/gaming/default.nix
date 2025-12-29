{pkgs, ...}: {
  imports = [
    ./lsfg.nix
    ./lutris.nix
    ./minecraft.nix
  ];

  home.packages = with pkgs; [
    mangohud
  ];
}
