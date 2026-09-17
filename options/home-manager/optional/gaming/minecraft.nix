{
  homes,
  lib,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf homes.game.prismlauncher (with pkgs; [
    fastclient
  ]);

  xdg.desktopEntries.fastclient = lib.mkIf homes.game.prismlauncher {
    type = "Application";
    name = "fastclient";
    exec = "fastclient";
    comment = "open fast client";
  };

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
