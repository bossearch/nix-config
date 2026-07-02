{
  hosts,
  lib,
  pkgs,
  ...
}: let
  lang = import ../.lang {inherit hosts lib pkgs;};
in {
  diagnostic.settings = {
    virtual_text = {
      spacing = 2;
      # prefix = "❯";
      prefix.__raw = ''
        function(diagnostic)
          local icons = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
          return "●"
        end
      '';
    };
    underline = false;
    float = false;
    severity_sort = true;
    signs.text.__raw = ''
      {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = "󰠠 ",
        [vim.diagnostic.severity.INFO] = " ",
      }
    '';
  };
  lsp = {
    inlayHints.enable = false;
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
      onAttach = ''
        client.server_capabilities.documentHighlightProvider = true
      '';
    };
}
