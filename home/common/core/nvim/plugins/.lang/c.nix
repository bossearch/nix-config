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
      c = ["clangtidy"];
      cpp = ["clangtidy"];
    };
    linters = {
      clangtidy = {
        cmd = lib.getExe' pkgs.clang-tools "clang-tidy";
      };
    };
  };
}
