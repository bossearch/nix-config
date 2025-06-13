{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/markdown.lua".text = ''
        vim.opt_local.formatoptions:append("r")
        vim.opt_local.formatoptions:append("o")
        vim.opt_local.comments = {
        	"b:- [ ]",
        	"b:- [x]",
        	"b:*",
        	"b:-",
        	"b:+",
        }
      '';
    };
  };
}
