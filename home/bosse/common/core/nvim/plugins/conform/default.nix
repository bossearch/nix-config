{
  config,
  lib,
  pkgs,
  ...
}: let
  lang = import ../.lang {inherit config pkgs lib;};
in {
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    lazyLoad = {
      settings = {
        cmd = [
          "ConformInfo"
        ];
        event = ["BufWrite"];
      };
    };
    settings =
      lang.conform
      // {
        format_on_save = {
          lspFallback = true;
          timeoutMs = 500;
        };
        notify_on_error = true;
      };
  };
}
