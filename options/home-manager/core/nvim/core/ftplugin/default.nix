{mylib, ...}: {
  imports = mylib.autoimport ./.;

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
