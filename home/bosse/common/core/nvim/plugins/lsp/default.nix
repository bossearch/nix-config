{
  config,
  pkgs,
  lib,
  ...
}: let
  lang = import ../.lang {inherit config pkgs lib;};
in {
  programs.nixvim = {
    diagnostic.settings = {
      virtual_text = true;
      underline = false;
      float = false;
    };
    plugins.lsp =
      lang.lsp
      // {
        enable = true;
        lazyLoad = {
          settings = {
            event = ["BufReadPre" "BufNewFile"];
          };
        };
        inlayHints = false;
        luaConfig.post = ''
          local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
          for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
          end
        '';
      };
  };
}
