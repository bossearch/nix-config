{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/nix.lua".text = ''
        vim.opt_local.formatoptions:remove({ 'r', 'o' })
      '';
    };
  };
}
