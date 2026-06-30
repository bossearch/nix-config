[
  {
    __unkeyed = "<leader>a";
    group = "Avante";
    icon = "󰭻 ";
    mode = ["n" "v"];
  }
  {
    __unkeyed = "<leader><cr>";
    group = "Siuu";
    icon = "󰌑 ";
    mode = "n";
  }
  {
    __unkeyed = "<leader><cr>/";
    __unkeyed-1 = "<cmd>lua require('oil').open(nil, { preview = {} })<cr>";
    desc = "Toggle Explorer";
    mode = "n";
  }
  {
    __unkeyed = "<leader><CR><CR>";
    __unkeyed-1.__raw = ''
      function()
        require("snacks").terminal.toggle(nil, {
          win = {
            height = 0.16,
            wo = { winbar = "" }
          },
          cwd = vim.fn.getcwd(),
        })
      end
    '';
    desc = "Toggle Terminal";
    mode = "n";
  }
]
