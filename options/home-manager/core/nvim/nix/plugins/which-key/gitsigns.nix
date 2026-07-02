[
  # Gitsigns
  {
    __unkeyed = "<leader>g";
    group = "Git";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>gs";
    __unkeyed-1 = "<cmd>Gitsigns stage_hunk<cr>";
    desc = "Stage Hunk";
    mode = "n";
  }
  {
    __unkeyed = "<leader>gS";
    __unkeyed-1 = "<cmd>Gitsigns stage_buffer<cr>";
    desc = "Stage Buffer";
    mode = "n";
  }
  {
    __unkeyed = "<leader>gr";
    __unkeyed-1 = "<cmd>Gitsigns reset_hunk<cr>";
    desc = "Reset Hunk";
    mode = "n";
  }
  {
    __unkeyed = "<leader>gR";
    __unkeyed-1 = "<cmd>Gitsigns reset_buffer<cr>";
    desc = "Reset Buffer";
    mode = "n";
  }
  {
    __unkeyed = "<leader>gu";
    __unkeyed-1 = "<cmd>Gitsigns undo_stage_hunk<cr>";
    desc = "Undo Stage Hunk";
    mode = "n";
  }
  {
    __unkeyed = "<leader>gp";
    # __unkeyed-1 = "<cmd>Gitsigns preview_hunk<cr>";
    __unkeyed-1 = "<cmd>Gitsigns preview_hunk_inline<cr>";
    mode = "n";
    desc = "Preview Hunk";
  }
  {
    __unkeyed = "<leader>gd";
    __unkeyed-1 = "<cmd>lua require('gitsigns').diffthis('~', {split = 'botright'})<cr>";
    desc = "Show Diff";
    mode = "n";
  }
  {
    __unkeyed = "<leader>gn";
    __unkeyed-1 = "<cmd>Gitsigns next_hunk<cr>";
    desc = "Next Hunk";
    mode = "n";
  }
  {
    __unkeyed = "<leader>gN";
    __unkeyed-1 = "<cmd>Gitsigns prev_hunk()<cr>";
    desc = "Prev Hunk";
    mode = "n";
  }
]
