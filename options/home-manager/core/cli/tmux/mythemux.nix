{pkgs, ...}: {
  home.file.".config/tmux/plugins/mythemux" = {
    source = pkgs.fetchFromGitHub {
      owner = "bossearch";
      repo = "mythemux";
      rev = "f1818515c77673aa160316217f150da58cc4b699";
      sha256 = "sha256-8TRhyEOmtvpENc1CC7hu573qZwBYwRsKK2J4EBQeTMk=";
    };
  };
}
