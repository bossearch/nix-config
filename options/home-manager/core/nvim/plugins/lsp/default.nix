{
  hosts,
  lib,
  pkgs,
  ...
}: let
  lang = import ../.lang {inherit hosts lib pkgs;};
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
        # Be aware that you also will need to properly configure your LSP server to
        # provide the inlay hints.
        inlayHints = false;
        # uncomment this if you're not want lsp hl some word
        # onAttach = ''
        #   client.server_capabilities.documentHighlightProvider = false
        # '';
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
