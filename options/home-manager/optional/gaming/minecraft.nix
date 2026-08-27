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
        pkgs.jdk21
        pkgs.jdk25
      ];
    };
  };
}
