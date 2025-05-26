{
  home.file."mythemux" = {
    source = builtins.fetchGit {
      url = "https://github.com/bossearch/mythemux";
      rev = "24a610c607c4e1c1c05cf420a968982167a7727a";
    };
    target = ".config/tmux/plugins/mythemux";
  };
}
