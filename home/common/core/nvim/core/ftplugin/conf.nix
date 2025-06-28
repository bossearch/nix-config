{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/conf.lua".text = ''
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
      '';
    };
  };
}
