{pkgs, ...}: {
  home.file.".config/tmux/plugins/mythemux" = {
    source = pkgs.fetchFromGitHub {
      owner = "bossearch";
      repo = "mythemux";
      rev = "66f9bea4c170c76ff653b48213d89234075dbef2";
      sha256 = "sha256-luZgSK5eliNjwck4T5AYaQXZ8CvktBpUravwyjBpet8=";
    };
  };
}
