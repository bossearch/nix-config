{
  homes,
  hosts,
  lib,
  pkgs,
  ...
}: let
  fontsMap = {
    "0xProto" = "_0xproto";
    "3270" = "_3270";
    "AdwaitaMono" = "adwaita-mono";
    "Agave" = "agave";
    "AnonymicePro" = "anonymice";
    "Arimo" = "arimo";
    "AtkynsonMono" = "atkynson-mono";
    "AurulentSansM" = "aurulent-sans-mono";
    "BigBlueTerm" = "bigblue-terminal";
    "BitstromWera" = "bitstream-vera-sans-mono";
    "BlexMono" = "blex-mono";
    "CaskaydiaCove" = "caskaydia-cove";
    "CaskaydiaMono" = "caskaydia-mono";
    "CodeNewRoman" = "code-new-roman";
    "ComicShannsMono" = "comic-shanns-mono";
    "CommitMono" = "commit-mono";
    "Cousine" = "cousine";
    "D2CodingLigature" = "d2coding";
    "DaddyTimeMono" = "daddy-time-mono";
    "DejaVuSansM" = "dejavu-sans-mono";
    "DepartureMono" = "departure-mono";
    "DroidSansM" = "droid-sans-mono";
    "EnvyCodeR" = "envy-code-r";
    "FantasqueSansM" = "fantasque-sans-mono";
    "FiraCode" = "fira-code";
    "FiraMono" = "fira-mono";
    "GeistMono" = "geist-mono";
    "GoMono" = "go-mono";
    "GoHuFont" = "gohufont";
    "Hack" = "hack";
    "Hasklug" = "hasklug";
    "HeavyData" = "heavy-data";
    "Hurmit" = "hurmit";
    "iMWriting" = "im-writing";
    "Inconsolata" = "inconsolata";
    "InconsolataGo" = "inconsolata-go";
    "Inconsolata LGC" = "inconsolata-lgc";
    "IntoneMono" = "intone-mono";
    "Iosevka" = "iosevka";
    "IosevkaTerm" = "iosevka-term";
    "IosevkaTermSlab" = "iosevka-term-slab";
    "JetBrainsMono" = "jetbrains-mono";
    "Lekton" = "lekton";
    "LiterationMono" = "liberation";
    "Lilex" = "lilex";
    "MartianMono" = "martian-mono";
    "MesloLG" = "meslo-lg";
    "Monaspice" = "monaspace";
    "Monofur" = "monofur";
    "Monoid" = "monoid";
    "Mononoki" = "mononoki";
    "M+" = "m+";
    "Noto" = "noto";
    "OpenDyslexic" = "open-dyslexic";
    "Overpass" = "overpass";
    "ProFont" = "profont";
    "ProggyClean" = "proggy-clean-tt";
    "RecMono" = "recursive-mono";
    "RobotoMono" = "roboto-mono";
    "ShureTechMono" = "shure-tech-mono";
    "SauceCodePro" = "sauce-code-pro";
    "SpaceMono" = "space-mono";
    "Symbols" = "symbols-only";
    "Terminess" = "terminess-ttf";
    "Tinos" = "tinos";
    "Ubuntu" = "ubuntu";
    "UbuntuMono" = "ubuntu-mono";
    "UbuntuSans" = "ubuntu-sans";
    "VictorMono" = "victor-mono";
    "ZedMono" = "zed-mono";
  };
  fontPkgName = fontsMap.${homes.nerdfont};
in {
  home.packages = lib.mkIf hosts.gui.enable (with pkgs; [
    noto-fonts
    noto-fonts-lgc-plus
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.${fontPkgName}
  ]);

  fonts.fontconfig = lib.mkIf (hosts.gui.enable) {
    enable = true;
    defaultFonts = {
      emoji = ["Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      serif = ["Noto Serif" "Noto Color Emoji"];
      monospace = ["Noto Sans Mono" "Noto Color Emoji"];
    };
  };
}
