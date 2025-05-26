{
  home.file."mythemux" = {
    source = builtins.fetchGit {
      url = "https://github.com/bossearch/mythemux";
      rev = "0b26335e17bb405b754cb3d22ca12f070c23fd20";
    };
    target = ".config/tmux/plugins/mythemux";
  };
}
