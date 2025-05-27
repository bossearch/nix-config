{
  programs.nixvim.extraConfigLua = ''
    require("outline").setup()
  '';
}
