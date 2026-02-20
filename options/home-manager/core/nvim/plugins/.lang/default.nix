# LSP lists
# https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lsp-configs
# Formatter lists
# https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
# Linter lists
# https://github.com/mfussenegger/nvim-lint#available-linters
{
  hosts,
  lib,
  pkgs,
}: let
  langs = [
    (import ./md {inherit lib pkgs;})
    (import ./bash.nix {inherit lib pkgs;})
    (import ./c.nix {inherit lib pkgs;})
    (import ./kt.nix {inherit lib pkgs;})
    (import ./lua.nix {inherit lib pkgs;})
    (import ./nix.nix {inherit hosts lib pkgs;})
  ];
  mergeAttrs = attrsList: builtins.foldl' lib.recursiveUpdate {} attrsList;
in
  mergeAttrs langs
