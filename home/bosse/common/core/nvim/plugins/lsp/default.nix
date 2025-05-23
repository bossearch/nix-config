{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    diagnostic.settings = {
      virtual_text = true;
      underline = false;
      float = false;
    };
    plugins.lsp = {
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
      servers = {
        bashls = import ./bashls.nix {inherit lib pkgs;};
        clangd = import ./clangd.nix {inherit pkgs;};
        lua_ls = import ./lua_ls.nix {inherit lib pkgs;};
        nixd = import ./nixd.nix {inherit config lib pkgs;};
      };
    };
  };
}
