{pkgs, ...}: {
  home.file."mythemux" = {
    source = pkgs.fetchFromGitHub {
      owner = "bossearch";
      repo = "mythemux";
      rev = "ed33d2488b84e1c2aaaaa24d6af2b8dcf661e636";
      sha256 = "sha256-e2mP5qjE8ysQW6gXtSYk99LvBksEJe7NBEex0+sTgGU=";
    };
    target = ".config/tmux/plugins/mythemux";
  };
}
