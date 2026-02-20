{
  hosts,
  lib,
  pkgs,
  ...
}: let
  lang = import ../.lang {inherit hosts lib pkgs;};
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
        format_on_save.__raw = ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
          end
        '';
        notify_on_error = true;
      };
  };
}
