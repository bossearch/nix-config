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
      # (type == "directory" && name != ".disable")
      (type == "directory" && lib.strings.stringLength name > 0 && lib.strings.substring 0 1 name != ".")
      (by-name + "/${name}/default.nix"))
    []
    (readDir by-name);
}
