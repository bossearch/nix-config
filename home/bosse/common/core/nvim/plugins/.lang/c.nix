{
  lib,
  pkgs,
}: {
  lsp = {
    servers = {
      clangd = {
        enable = true;
      };
    };
  };

  conform = {
    formatters_by_ft = {
      c = ["clang_format"];
      cpp = ["clang_format"];
    };
    formatters = {
      clang_format = {
        command = lib.getExe' pkgs.clang-tools "clang-format";
      };
    };
  };

  lint = {
    lintersByFt = {
      c = ["clang_tidy"];
      cpp = ["clang_tidy"];
    };
    linters = {
      clang_tidy = {
        cmd = lib.getExe' pkgs.clang-tools "clang-tidy";
      };
    };
  };
}
