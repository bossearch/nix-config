{lib, ...}: {
  imports =
    [./core]
    ++ lib.foldlAttrs
    (
      acc: name: type:
        acc
        ++ (
          if type == "regular" && lib.hasSuffix ".nix" name
          then [(./optional + "/${name}")]
          else []
        )
    )
    []
    (builtins.readDir ./optional);
}
