{lib, ...}: {
  imports =
    lib.foldlAttrs
    (
      acc: name: type:
        acc
        ++ (
          if type == "regular" && name != "default.nix"
          then [./${name}]
          else []
        )
    )
    []
    (builtins.readDir ./.);

  programs.nixvim = {
    filetype = {
      extension = {
        vpy = "python";
      };
      filename.__raw = ''
        {
          [".nixos.log"] = "apache",
          [".hm.log"] = "apache",
        }
      '';
      pattern.__raw = ''
        {
          ['.*/hypr/.*%.conf'] = 'hyprlang',
        }
      '';
    };
  };
}
