{
  hosts,
  lib,
  pkgs,
  ...
}: let
  lang = import ../.lang {inherit hosts lib pkgs;};
in {
  plugins.lint =
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
