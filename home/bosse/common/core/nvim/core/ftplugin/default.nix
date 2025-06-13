let
  by-name = ./.;
  nixFiles = builtins.filter (f: f != "default.nix") (builtins.attrNames (builtins.readDir by-name));
in {
  imports = map (f: by-name + "/${f}") nixFiles;

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
