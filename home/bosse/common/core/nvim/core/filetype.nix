{
  programs.nixvim = {
    filetype = {
      extension = {
        vpy = "python";
      };
      filename.__raw = ''
        {
          [".nixos.log"] = "sh",
          [".hm.log"] = "sh",
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
