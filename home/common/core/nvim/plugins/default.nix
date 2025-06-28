{lib, ...}: {
  imports =
    lib.foldlAttrs
    (
      acc: name: type:
        acc
        ++ lib.optional
        (type == "directory" && lib.strings.stringLength name > 0 && lib.strings.substring 0 1 name != ".")
        ./${name}/default.nix
    )
    []
    (builtins.readDir ./.);
}
