{pkgs, ...}: let
  mediainfo-plugins = pkgs.fetchFromGitHub {
    owner = "boydaihungst";
    repo = "mediainfo.yazi";
    rev = "af8bdf47a1f4dcfefe433aa2134b04eb9c75a10b";
    sha256 = "sha256-io3HyoUniWZu+0efZfbhXn8JoG5p2/lFeH/FguVvjSY=";
  };
in {
  programs.yazi.plugins = {
    chmod = pkgs.yaziPlugins.chmod;
    full-border = pkgs.yaziPlugins.full-border;
    git = pkgs.yaziPlugins.git;
    no-status = pkgs.yaziPlugins.no-status;
    ouch = pkgs.yaziPlugins.smart-enter;
    smart-enter = pkgs.yaziPlugins.smart-enter;
    smart-paste = pkgs.yaziPlugins.smart-paste;
    mediainfo = "${mediainfo-plugins}";
  };
}
