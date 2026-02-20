{lib, ...}: {
  imports =
    [./core]
    ++ lib.foldlAttrs
    (
      acc: name: type:
        acc
        ++ (
          if type == "regular" || type == "directory"
          then [(./optional + "/${name}")]
          else []
        )
    )
    []
    (builtins.readDir ./optional);
}
