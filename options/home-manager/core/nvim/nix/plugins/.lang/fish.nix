{
  lsp = {
    servers = {
      fish_lsp = {
        enable = true;
      };
    };
  };

  conform = {
    formatters_by_ft = {
      fish = ["fish_indent"];
    };
  };

  lint = {
    lintersByFt = {
      fish = ["fish"];
    };
  };
}
