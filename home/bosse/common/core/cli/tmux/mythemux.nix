{
  home.file."mythemux" = {
    source = builtins.fetchGit {
      url = "https://github.com/bossearch/mythemux";
      rev = "6c43ef579ca725028ae821d17a89e3a5ff798e30";
    };
    target = ".config/tmux/plugins/mythemux";
  };
}
