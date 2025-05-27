[
  # Treesitter
  {
    __unkeyed = "<leader>t";
    group = "Treesitter";
    icon = "󰐅 ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>ts";
    __unkeyed-1.__raw = ''
      function()
        require("mini.splitjoin").split()
      end
    '';
    desc = "Treesitter split";
    mode = "n";
  }
  {
    __unkeyed = "<leader>tj";
    __unkeyed-1.__raw = ''
      function()
        require("mini.splitjoin").join()
      end
    '';
    desc = "Treesitter join";
    mode = "n";
  }
]
