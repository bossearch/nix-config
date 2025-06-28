[
  # Telescope
  {
    __unkeyed = "<leader>f";
    group = "Find";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>ff";
    __unkeyed-1 = "<cmd>Telescope find_files<cr>";
    desc = "Find Files In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader>fr";
    __unkeyed-1 = "<cmd>Telescope oldfiles<cr>";
    desc = "Find Recent Files";
    mode = "n";
  }
  {
    __unkeyed = "<leader>fg";
    # __unkeyed-1 = "<cmd>Telescope live_grep<cr>";
    __unkeyed-1.__raw = ''
      function()
        require("lib.util").live_multigrep()
      end
    '';
    desc = "Find String In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader>fc";
    __unkeyed-1 = "<cmd>Telescope grep_string<cr>";
    desc = "Find String Under Cursor In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader>fh";
    __unkeyed-1 = "<cmd>Telescope help_tags<cr>";
    desc = "Find Help Tags";
    mode = "n";
  }
  {
    __unkeyed = "<leader>fb";
    __unkeyed-1 = "<cmd>Telescope buffers<cr>";
    desc = "Find Buffer";
    mode = "n";
  }
  {
    __unkeyed = "<leader>fd";
    __unkeyed-1 = "<cmd>Telescope diagnostics<cr>";
    desc = "Find Diagnostic";
    mode = "n";
  }
  {
    __unkeyed = "<leader>ft";
    __unkeyed-1 = "<cmd>TodoTelescope theme=ivy previewer=false layout_config={bottom_pane={height=10}}<cr>";
    desc = "Find Todos";
    mode = "n";
  }
]
