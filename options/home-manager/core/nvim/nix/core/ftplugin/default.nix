{mylib, ...}: {
  imports = mylib.autoimport ./.;

  filetype = {
    extension = {
      vpy = "python";
    };
    filename.__raw = ''
      {
        [".rb.log"] = "apache",
        [".hm.log"] = "apache",
      }
    '';
    pattern.__raw = ''
      {
        ['.*/hypr/.*%.conf'] = 'hyprlang',
      }
    '';
  };
}
