{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.outline-nvim];
    extraConfigLua = ''
      require("outline").setup()
    '';
  };
}
