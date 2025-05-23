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
    __unkeyed-1 = "<cmd>q<cr>";
    desc = "Quit Window";
    mode = "n";
  }
  {
    __unkeyed = "<leader>wbq";
    __unkeyed-1 = "<cmd>bd<cr>";
    desc = "Quit Buffer";
    mode = "n";
  }
  {
    __unkeyed = "<leader>wz";
    __unkeyed-1.__raw = ''
      function()
        require("snacks").zen()
      end
    '';
    desc = "Toggle Zen Mode";
    mode = "n";
  }
  {
    __unkeyed = "<leader>wm";
    __unkeyed-1.__raw = ''
      function()
        require("snacks").zen.zoom()
      end
    '';
    desc = "Maximize Window";
    mode = "n";
  }
]
