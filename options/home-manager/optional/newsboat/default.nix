{
  homes,
  lib,
  pkgs,
  ...
}: {
  programs.newsboat = {
    enable = homes.newsboat;
    browser = "${pkgs.xdg-utils}/bin/xdg-open";
    urls =
      (import ./.urls/github.nix)
      ++ (import ./.urls/other.nix)
      ++ (import ./.urls/reddit.nix)
      ++ (import ./.urls/youtube.nix);
    queries = import ./tags.nix;
    extraConfig = import ./config.nix {inherit pkgs;};
  };
  xdg.desktopEntries.newsboat = lib.mkIf homes.newsboat {
    type = "Application";
    name = "newsboat";
    exec = "kitty -T newsboat newsboat";
    comment = "Open newsboat with kitty";
  };
}
