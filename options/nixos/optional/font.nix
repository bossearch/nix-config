{
  hosts,
  lib,
  pkgs,
  ...
}: {
  fonts = lib.mkIf (!hosts.gui.enable) {
    packages = with pkgs;
      [
        noto-fonts
        noto-fonts-lgc-plus
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ]
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

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
}
