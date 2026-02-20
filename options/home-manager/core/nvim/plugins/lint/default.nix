{
  hosts,
  lib,
  pkgs,
  ...
}: let
  lang = import ../.lang {inherit hosts lib pkgs;};
in {
  programs.nixvim.plugins.lint =
    lang.lint
    // {
      enable = true;
      lazyLoad = {
        settings = {
          event = ["BufReadPre" "BufNewFile"];
        };
      };
    };
}
