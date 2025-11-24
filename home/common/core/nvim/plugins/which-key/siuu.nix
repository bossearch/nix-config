[
  {
    __unkeyed = "<cr>/";
    __unkeyed-1 = "<cmd>lua Snacks.explorer()<cr>";
    desc = "Open Explorer";
    mode = "n";
  }
  {
    __unkeyed = "<cr>f";
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
    __unkeyed = "<cr>d";
    __unkeyed-1.__raw = ''
      function()
        detail = not detail
        if detail then
          require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
        else
          require("oil").set_columns({})
        end
      end
    '';
    desc = "Open Oil On Detail View";
    mode = "n";
  }
  {
    __unkeyed = "<cr><cr>";
    __unkeyed-1.__raw = ''
      function()
        require("snacks").terminal.open("fish", {
          win = {
            width = 0.8,         -- Width of the terminal
            height = 0.8,        -- Height of the terminal
            border = "rounded",  -- Sharp border style (use "double" if preferred)
          },
          cwd = vim.fn.getcwd(), -- Set the current working directory
          auto_close = true,
        })
      end
    '';
    desc = "Toggle Terminal On Float";
    mode = "n";
  }
]
