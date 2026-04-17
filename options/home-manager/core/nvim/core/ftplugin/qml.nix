{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/qml.lua".text = ''
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
      '';
    };
  };
}
