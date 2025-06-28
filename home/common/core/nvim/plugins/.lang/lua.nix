{
  lib,
  pkgs,
}: {
  lsp = {
    servers = {
      lua_ls = {
        enable = true;
      };
    };
  };

  conform = {
    formatters_by_ft = {
      lua = ["stylua"];
    };
    formatters = {
      stylua = {
        command = lib.getExe pkgs.stylua;
      };
    };
  };

  lint = {
    lintersByFt = {
      lua = ["luacheck"];
    };
    linters = {
      luacheck = {
        cmd = lib.getExe pkgs.luaPackages.luacheck;
      };
    };
  };
}
