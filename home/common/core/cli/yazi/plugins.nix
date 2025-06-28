{pkgs, ...}: let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "4df8f70eb643963f6b2d32045342fee311ea95fd";
    sha256 = "sha256-PZcVDFuU8cQ8QO8nmwlHpDbT3p61shtREHnJZoC7oPI=";
  };
  ouch-plugins = pkgs.fetchFromGitHub {
    owner = "ndtoan96";
    repo = "ouch.yazi";
    rev = "2496cd9ac2d1fb52597b22ae84f3af06c826a86d";
    sha256 = "sha256-EDEIiZJy/RfXVaLNsKDeklH4qY2h+js2m0y6VSAjPkk=";
  };
  mediainfo-plugins = pkgs.fetchFromGitHub {
    owner = "boydaihungst";
    repo = "mediainfo.yazi";
    rev = "70ed2287159b17bf2b9c1598252c5c33ba52b8a3";
    sha256 = "sha256-MMsKb9+zeOtWrpE3SalWhGIqeOwHrLdwf8xWYvWXjbo=";
  };
in {
  programs.yazi.plugins = {
    chmod = "${yazi-plugins}/chmod.yazi";
    full-border = "${yazi-plugins}/full-border.yazi";
    git = "${yazi-plugins}/git.yazi";
    mediainfo = "${mediainfo-plugins}";
    no-status = "${yazi-plugins}/no-status.yazi";
    ouch = "${ouch-plugins}";
    smart-enter = "${yazi-plugins}/smart-enter.yazi";
    smart-paste = "${yazi-plugins}/smart-paste.yazi";
  };
}
