# TODO: plugin to consider trouble, substitute, comment, typr
# TODO: Add markdown plugin suite
# TODO: Learn more about treesitter textobjects
{lib, ...}: let
  inherit (builtins) readDir;
  inherit (lib.attrsets) foldlAttrs;
  inherit (lib.lists) optional;
  by-name = ./.;
in {
  imports =
    foldlAttrs
    (acc: name: type:
      acc
      ++ optional
      (type == "directory" && name != ".disable")
      (by-name + "/${name}/default.nix"))
    []
    (readDir by-name);
}
