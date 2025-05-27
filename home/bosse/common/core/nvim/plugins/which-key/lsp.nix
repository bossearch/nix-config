[
  # LSP
  {
    __unkeyed = "<leader>l";
    group = "LSP";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>ld";
    __unkeyed-1 = "<cmd>lua vim.lsp.buf.definition()<cr>";
    desc = "Definition";
    mode = "n";
  }
  {
    __unkeyed = "<leader>lD";
    __unkeyed-1 = "<cmd>lua vim.lsp.buf.declarations()<cr>";
    desc = "Declaration";
    mode = "n";
  }
  {
    __unkeyed = "<leader>lr";
    __unkeyed-1 = "<cmd>lua vim.lsp.buf.references()<cr>";
    desc = "Reference";
    mode = "n";
  }
  {
    __unkeyed = "<leader>li";
    __unkeyed-1 = "<cmd>lua vim.lsp.buf.Implementation()<cr>";
    desc = "Implementation";
    mode = "n";
  }
  {
    __unkeyed = "<leader>lt";
    __unkeyed-1 = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
    desc = "Type Definition";
    mode = "n";
  }
  {
    __unkeyed = "<leader>lh";
    __unkeyed-1 = "<cmd>lua vim.lsp.buf.hover()<cr>";
    desc = "Hover";
    mode = "n";
  }
  {
    __unkeyed = "<leader>ls";
    __unkeyed-1 = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
    desc = "Signature Help";
    mode = "n";
  }
  {
    __unkeyed = "<leader>lc";
    __unkeyed-1 = "<cmd>lua vim.lsp.buf.code_action()<cr>";
    desc = "Code Action";
    mode = "n";
  }
  {
    __unkeyed = "<leader>ll";
    __unkeyed-1 = "<cmd>lua vim.lsp.codelens.run()<cr>";
    desc = "Codelens Run";
    mode = "n";
  }
  {
    __unkeyed = "<leader>lL";
    __unkeyed-1 = "<cmd>lua vim.lsp.codelens.refresh()<cr>";
    desc = "Codelens Refresh";
    mode = "n";
  }
  {
    __unkeyed = "<leader>lR";
    __unkeyed-1 = "<cmd>lua vim.lsp.buf.rename()<cr>";
    desc = "Rename";
    mode = "n";
  }
  {
    __unkeyed = "<leader>ln";
    __unkeyed-1.__raw = ''
      function()
        Snacks.rename.rename_file()
      end
    '';
    desc = "Rename File";
    mode = "n";
  }
]
