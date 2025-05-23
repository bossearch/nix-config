[
  # QuickFix
  {
    __unkeyed = "<leader>q";
    group = "Quickfix";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qq";
    __unkeyed-1 = "<cmd>cclose<cr>";
    desc = "Close Quickfix List";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qk";
    __unkeyed-1 = "<cmd>cprev<cr>";
    desc = "Prev Quickfix List";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qj";
    __unkeyed-1 = "<cmd>cnext<cr>";
    desc = "Next Quickfix List";
    mode = "n";
  }
  {
    __unkeyed = "<leader>q:";
    __unkeyed-1 = ":cdo";
    desc = "Edit Quickfix List";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qt";
    __unkeyed-1 = "<cmd>TodoQuickFix<cr>";
    desc = "Open Todo in Quickfix";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qd";
    group = "Open Quickfix Diagnostic";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qda";
    __unkeyed-1 = "<cmd>lua vim.diagnostic.setqflist()<cr>";
    desc = "Open Quickfix All Diagnostic";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qde";
    __unkeyed-1 = "<cmd>lua vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})<cr>";
    desc = "Open Quickfix Error Diagnostic";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qdw";
    __unkeyed-1 = "<cmd>lua vim.diagnostic.setqflist({severity = vim.diagnostic.severity.WARN})<cr>";
    desc = "Open Quickfix Warn Diagnostic";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qdi";
    __unkeyed-1 = "<cmd>lua vim.diagnostic.setqflist({severity = vim.diagnostic.severity.INFO})<cr>";
    desc = "Open Quickfix Info Diagnostic";
    mode = "n";
  }
  {
    __unkeyed = "<leader>qdh";
    __unkeyed-1 = "<cmd>lua vim.diagnostic.setqflist({severity = vim.diagnostic.severity.HINT})<cr>";
    desc = "Open Quickfix Hint Diagnostic";
    mode = "n";
  }
]
