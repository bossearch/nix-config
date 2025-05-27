[
  # Terminal
  {
    __unkeyed = "<leader><CR>";
    group = "Terminal";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader><CR><CR>";
    __unkeyed-1.__raw = ''
      function()
        require("snacks").terminal.toggle(nil, { win = { height = 0.5 } })
      end
    '';
    desc = "Toggle Terminal On Split";
    mode = ["n" "t"];
  }
  {
    __unkeyed = "<leader><CR>f";
    __unkeyed-1.__raw = ''
      function()
        require("snacks").terminal.toggle("zsh", {
          win = {
            width = 0.9,         -- Width of the terminal
            height = 0.9,        -- Height of the terminal
            border = "rounded",  -- Sharp border style (use "double" if preferred)
          },
          cwd = vim.fn.getcwd(), -- Set the current working directory
        })
      end
    '';
    desc = "Toggle Terminal On Float";
    mode = ["n" "t"];
  }
]
