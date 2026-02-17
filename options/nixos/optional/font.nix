{
  hosts,
  lib,
  pkgs,
  ...
}: let
  headless = hosts.windowmanager == null;
in {
  config = lib.mkIf (!headless) {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.meslo-lg
        nerd-fonts.commit-mono
        noto-fonts
        noto-fonts-lgc-plus
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = ["Noto Color Emoji"]; # Correct font family name
          sansSerif = ["Noto Sans" "Noto Color Emoji"];
          serif = ["Noto Serif" "Noto Color Emoji"];
          monospace = ["Noto Sans Mono" "Noto Color Emoji"];
        };
        useEmbeddedBitmaps = true;
      };
    };
  };
}
