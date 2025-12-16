# LSP lists
# https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lsp-configs
# Formatter lists
# https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
# Linter lists
# https://github.com/mfussenegger/nvim-lint#available-linters
{
  config,
  pkgs,
  lib,
}: let
  langs = [
    (import ./md {inherit pkgs lib;})
    (import ./bash.nix {inherit pkgs lib;})
    (import ./c.nix {inherit pkgs lib;})
    (import ./kt.nix {inherit pkgs lib;})
    (import ./lua.nix {inherit pkgs lib;})
    (import ./nix.nix {inherit config pkgs lib;})
  ];
  mergeAttrs = attrsList: builtins.foldl' lib.recursiveUpdate {} attrsList;
in
  mergeAttrs langs
