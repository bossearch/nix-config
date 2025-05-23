{...}: {
  imports = [./plugins];
}
# Not work, needs home-manager unstable or yazi -v is updated on stable branch
# {pkgs, ...}: let
#   yazi-plugins = pkgs.fetchFromGitHub {
#     owner = "yazi-rs";
#     repo = "plugins";
#     rev = "55bf6996ada3df4cbad331ce3be0c1090769fc7c";
#     sha256 = "sha256-v/C+ZBrF1ghDt1SXpZcDELmHMVAqfr44iWxzUWynyRk=";
#   };
#   ouch-plugins = pkgs.fetchFromGitHub {
#     owner = "ndtoan96";
#     repo = "ouch.yazi";
#     rev = "2496cd9ac2d1fb52597b22ae84f3af06c826a86d";
#     sha256 = "sha256-EDEIiZJy/RfXVaLNsKDeklH4qY2h+js2m0y6VSAjPkk=";
#   };
#   mediainfo-plugins = pkgs.fetchFromGitHub {
#     owner = "boydaihungst";
#     repo = "mediainfo.yazi";
#     rev = "9629b1e85c3757c834ec83fb7d931982c55f4c3f";
#     sha256 = "sha256-EDEIiZJy/RfXVaLNsKDeklH4qY2h+js2m0y6VSAjPkk=";
#   };
# in {
#   programs.yazi.plugins = {
#     chmod = "${yazi-plugins}/chmod.yazi";
#     full-border = "${yazi-plugins}/full-border.yazi";
#     git = "${yazi-plugins}/git.yazi";
#     mediainfo = "${mediainfo-plugins}/mediainfo.yazi";
#     no-status = "${yazi-plugins}/no-status.yazi";
#     ouch = "${ouch-plugins}/ouch.yazi";
#     smart-enter = "${yazi-plugins}/smart-enter.yazi";
#     smart-paste = "${yazi-plugins}/smart-paste.yazi";
#   };
# }

