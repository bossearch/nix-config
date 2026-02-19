{
  hosts,
  lib,
  outputs,
  ...
}: {
  imports =
    lib.foldlAttrs
    (
      acc: name: type:
        acc
        ++ (
          if name == "default.nix"
          then []
          else if type == "regular" || type == "directory"
          then [./${name}]
          else []
        )
    )
    []
    (builtins.readDir ./.)
    ++ (builtins.attrValues outputs.nixosModules);

  time.timeZone = "${hosts.timezone}";

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
}
