{
  config,
  lib,
  pkgs,
  ...
}: let
  lang = import ../.lang {inherit config pkgs lib;};
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
