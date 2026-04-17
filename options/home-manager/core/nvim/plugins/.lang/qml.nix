{
  lib,
  pkgs,
}: {
  lsp = {
    servers = {
      qmlls = {
        enable = true;
      };
    };
  };

  conform = {
    formatters_by_ft = {
      qml = ["qmlformat"];
    };
    formatters = {
      qmlformat = {
        command = lib.getExe' pkgs.kdePackages.qtdeclarative "qmlformat";
      };
    };
  };
}
