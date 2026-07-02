[
  # Window
  {
    __unkeyed = "<leader>w";
    group = "Window";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>wk";
    __unkeyed-1 = "<cmd>resize +2<cr>";
    desc = "Increase Window Height";
    mode = "n";
  }
  {
    __unkeyed = "<leader>wj";
    __unkeyed-1 = "<cmd>resize -2<cr>";
    desc = "Decrease Window Height";
    mode = "n";
  }
  {
    __unkeyed = "<leader>wh";
    __unkeyed-1 = "<cmd>vertical resize -2<cr>";
    desc = "Decrease Window Width";
    mode = "n";
  }
  {
    __unkeyed = "<leader>wl";
    __unkeyed-1 = "<cmd>vertical resize +2<cr>";
    desc = "Increase Window Width";
    mode = "n";
  }
  {
    __unkeyed = "<leader>wq";
    __unkeyed-1.__raw = ''
      function()
        require("lib.util").smart_bdelete()
      end
    '';
    desc = "Quit Buffer";
    mode = "n";
  }
]
