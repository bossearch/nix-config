{
  lib,
  pkgs,
}: {
  lsp = {
    servers = {
      bashls = {
        enable = true;
      };
    };
  };

  conform = {
    formatters_by_ft = {
      sh = ["shfmt"];
      bash = ["shfmt"];
    };
    formatters = {
      shfmt = {
        command = lib.getExe pkgs.shfmt;
      };
    };
  };

  lint = {
    lintersByFt = {
      sh = ["shellcheck"];
      bash = ["shellcheck"];
    };
    linters = {
      shellcheck = {
        cmd = lib.getExe pkgs.shellcheck;
      };
    };
  };
}
