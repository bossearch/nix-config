{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.outline-nvim];
  extraConfigLua = ''
    require("outline").setup()
  '';
}
