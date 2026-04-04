{pkgs, ...}: {
  home.file."mythemux" = {
    source = pkgs.fetchFromGitHub {
      owner = "bossearch";
      repo = "mythemux";
      rev = "46c4e3ebb302010cb1f257a3579c0be6bd9058b9";
      sha256 = "sha256-FpIJexwnNl/q/5aPiYuQCCQDv+yMAaHhIGO5tuvlNLs=";
    };
    target = ".config/tmux/plugins/mythemux";
  };
}
