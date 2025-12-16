{
  lib,
  pkgs,
}: {
  lsp = {
    servers = {
      kotlin_language_server = {
        enable = true;
      };
    };
  };

  conform = {
    formatters_by_ft = {
      kt = ["ktfmt"];
    };
    formatters = {
      clang_format = {
        command = lib.getExe pkgs.ktfmt;
      };
    };
  };

  lint = {
    lintersByFt = {
      kt = ["ktlint"];
    };
    linters = {
      ktlint = {
        cmd = lib.getExe pkgs.ktlint;
      };
    };
  };
}
