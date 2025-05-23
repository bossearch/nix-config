[
  # File
  {
    __unkeyed = "<leader>/";
    group = "File";
    icon = "󱧶 ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>//";
    __unkeyed-1 = "<cmd>lua Snacks.explorer()<cr>";
    desc = "Open Explorer";
    mode = "n";
  }
  {
    __unkeyed = "<leader>/oo";
    __unkeyed-1.__raw = ''
      function()
        vim.g.oil_open_in_buffer = true
        require("oil").open()
      end
    '';
    desc = "Open Oil";
    mode = "n";
  }
  {
    __unkeyed = "<leader>/of";
    __unkeyed-1.__raw = ''
      function()
        vim.g.oil_open_in_buffer = false
        require("oil").toggle_float()
      end
    '';
    desc = "Open Oil On Floating Mode";
    mode = "n";
  }
  {
    __unkeyed = "<leader>/od";
    __unkeyed-1.__raw = ''
      function()
        detail = not detail
        if detail then
          require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
        else
          require("oil").set_columns({ "icon" })
        end
      end
    '';
    desc = "Open Oil On Detail View";
    mode = "n";
  }
  {
    __unkeyed = "<leader>/yy";
    __unkeyed-1 = "<cmd>Yazi cwd<cr>";
    desc = "Open Yazi At Root Dir";
    mode = "n";
  }
  {
    __unkeyed = "<leader>/yf";
    __unkeyed-1 = "<cmd>Yazi<cr>";
    desc = "Open yazi at the current file";
    mode = "n";
  }
]
