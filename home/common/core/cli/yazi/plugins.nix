{pkgs, ...}: let
  mediainfo-plugins = pkgs.fetchFromGitHub {
    owner = "boydaihungst";
    repo = "mediainfo.yazi";
    rev = "c6d0de764f6e667c1a7a49f8acc9030c02a1a45c";
    sha256 = "sha256-CVHY66AcOC0STi+uDwbKe+HI3WN7MPgszlFHB479V/E=";
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
