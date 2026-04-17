{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/fish.lua".text = ''
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
      '';
    };
  };
}
