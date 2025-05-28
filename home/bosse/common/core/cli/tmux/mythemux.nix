{pkgs, ...}: {
  home.file."mythemux" = {
    source = pkgs.fetchFromGitHub {
      owner = "bossearch";
      repo = "mythemux";
      rev = "57ab6a50a3c77458ad1c8b59061fcabdeab7bab3";
      sha256 = "sha256-pKFy0+5NoBC9MvVD+5G/xzUGlk1+63qV3osHITASp3U=";
    };
    target = ".config/tmux/plugins/mythemux";
  };
}
