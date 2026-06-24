{
  homes,
  lib,
  pkgs,
  ...
}: {
  programs.prismlauncher = lib.mkIf homes.game.prismlauncher {
    enable = true;
    package = pkgs.prismlauncher.override {
      jdks = [
        pkgs.jre21_minimal
        pkgs.jre25_minimal
      ];
      additionalLibs = with pkgs; [
        wayland
        libXcursor
        libXrandr
        libXi
        libXinerama
        libXfixes
        libXrender
      ];
    };
  };
}
