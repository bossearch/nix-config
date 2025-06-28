{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/lua.lua".text = ''
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
      '';
    };
  };
}
