{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/gitcommit.lua".text = ''
        vim.opt_local.formatoptions:append("r")
        vim.opt_local.formatoptions:append("o")
        vim.opt_local.comments = {
        	"b:*",
        	"b:-",
        }
      '';
    };
  };
}
