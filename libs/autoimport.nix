{lib}: {
  autoimport = path:
    lib.foldlAttrs (
      acc: name: type:
        acc
        ++ lib.optional (
          (type
            == "regular"
            && lib.hasSuffix ".nix" name
            && name != "default.nix"
            && !(lib.hasPrefix "." name))
          || (type
            == "directory"
            && !(lib.hasPrefix "." name))
        ) (path + "/${name}")
    ) [] (builtins.readDir path);
}
