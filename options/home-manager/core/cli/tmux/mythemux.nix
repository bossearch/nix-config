{pkgs, ...}: {
  home.file.".config/tmux/plugins/mythemux" = {
    source = pkgs.fetchFromGitHub {
      owner = "bossearch";
      repo = "mythemux";
      rev = "d52ad8c7ece60961644de8df0e9e2ec27fff93ec";
      sha256 = "sha256-Oc5DsSyvnXg5RMqRUmREb5jFYfiNgMIbTtkSolgSSeE=";
    };
  };
}
