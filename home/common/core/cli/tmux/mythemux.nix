{pkgs, ...}: {
  home.file."mythemux" = {
    source = pkgs.fetchFromGitHub {
      owner = "bossearch";
      repo = "mythemux";
      rev = "4250787c7ffc407134c4c0d3111479f8cede674d";
      sha256 = "sha256-JZ/OF7VGKHyMhChKi7+SGYQvszlHricAK5qJQUl8VYY=";
    };
    target = ".config/tmux/plugins/mythemux";
  };
}
