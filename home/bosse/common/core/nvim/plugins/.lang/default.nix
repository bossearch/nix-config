{
  config,
  pkgs,
  lib,
}: let
  langs = [
    (import ./bash.nix {inherit pkgs lib;})
    (import ./c.nix {inherit pkgs lib;})
    (import ./lua.nix {inherit pkgs lib;})
    (import ./nix.nix {inherit config pkgs lib;})
  ];
  mergeAttrs = attrsList: builtins.foldl' lib.recursiveUpdate {} attrsList;
in
  mergeAttrs langs
