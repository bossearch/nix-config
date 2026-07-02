[
  # picker
  {
    __unkeyed = "<leader><space>";
    group = "Picker";
    icon = "󰢷 ";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space><space>";
    __unkeyed-1 = "<cmd>lua Snacks.picker.smart()<cr>";
    desc = "Smart Find Files";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>f";
    __unkeyed-1 = "<cmd>lua Snacks.picker.files({hidden=true,follow=true,ignored=true})<cr>";
    desc = "Find Files In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>p";
    __unkeyed-1 = "<cmd>lua Snacks.picker.projects()<cr>";
    desc = "Find Projects";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>r";
    __unkeyed-1 = "<cmd>lua Snacks.picker.recent()<cr>";
    desc = "Find Recent Files";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>w";
    __unkeyed-1 = "<cmd>lua Snacks.picker.grep()<cr>";
    desc = "Find String In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>c";
    __unkeyed-1 = "<cmd>lua Snacks.picker.grep_word()<cr>";
    desc = "Find String Under Cursor In CWD";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>L";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lines()<cr>";
    desc = "Find Lines";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>q";
    __unkeyed-1 = "<cmd>lua Snacks.picker.qflist()<cr>";
    desc = "Find Quickfix List";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>h";
    __unkeyed-1 = "<cmd>lua Snacks.picker.help()<cr>";
    desc = "Find Help Tags";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>b";
    __unkeyed-1 = "<cmd>lua Snacks.picker.buffers()<cr>";
    desc = "Find Buffer";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>d";
    __unkeyed-1 = "<cmd>lua Snacks.picker.diagnostics()<cr>";
    desc = "Find Diagnostic";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>t";
    __unkeyed-1 = "<cmd>lua Snacks.picker.todo_comments()<cr>";
    desc = "Find Todos";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>.";
    __unkeyed-1 = "<cmd>lua Snacks.picker.icons()<cr>";
    desc = "Find Icons";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>n";
    __unkeyed-1 = "<cmd>lua Snacks.picker.notifications()<cr>";
    desc = "Find Notifications";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>:";
    __unkeyed-1 = "<cmd>lua Snacks.picker.command_history()<cr>";
    desc = "Find Command History";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>/";
    __unkeyed-1 = "<cmd>lua Snacks.picker.search_history()<cr>";
    desc = "Find Search History";
    mode = "n";
  }
  {
    __unkeyed = ''<leader><space>"'';
    __unkeyed-1 = "<cmd>lua Snacks.picker.registers()<cr>";
    desc = "Find Registers";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>'";
    __unkeyed-1 = "<cmd>lua Snacks.picker.marks()<cr>";
    desc = "Find Marks";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>v";
    __unkeyed-1 = "<cmd>lua Snacks.picker.cliphist()<cr>";
    desc = "Find Cliphist";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>j";
    __unkeyed-1 = "<cmd>lua Snacks.picker.jumps()<cr>";
    desc = "Find Jumps";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>u";
    __unkeyed-1 = "<cmd>lua Snacks.picker.undo()<cr>";
    desc = "Find Undo";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>s";
    __unkeyed-1 = "<cmd>lua Snacks.picker.spelling()<cr>";
    desc = "Find Spelling";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>z";
    __unkeyed-1 = "<cmd>lua Snacks.picker.zoxide()<cr>";
    desc = "Find Zoxide";
    mode = "n";
  }
  # picker.git
  {
    __unkeyed = "<leader><space>g";
    group = "Git";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>gb";
    __unkeyed-1 = "<cmd>lua Snacks.picker.git_branches()<cr>";
    desc = "Find Git Branches";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>gl";
    __unkeyed-1 = "<cmd>lua Snacks.picker.git_log()<cr>";
    desc = "Find Git Log";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>gL";
    __unkeyed-1 = "<cmd>lua Snacks.picker.git_log_file()<cr>";
    desc = "Find Git Log File";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>gs";
    __unkeyed-1 = "<cmd>lua Snacks.picker.git_status()<cr>";
    desc = "Find Git Status";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>gS";
    __unkeyed-1 = "<cmd>lua Snacks.picker.git_stash()<cr>";
    desc = "Find Git Stash";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>gd";
    __unkeyed-1 = "<cmd>lua Snacks.picker.git_diff()<cr>";
    desc = "Find Git Diff (Hunks)";
    mode = "n";
  }
  # picker.lsp
  {
    __unkeyed = "<leader><space>l";
    group = "LSP";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>lc";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lsp_config()<cr>";
    desc = "Find LSP Configs";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>ld";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lsp_definitions()<cr>";
    desc = "Find LSP Definitions";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>lD";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lsp_declarations()<cr>";
    desc = "Find LSP Declarations";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>lr";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lsp_references()<cr>";
    desc = "Find LSP References";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>li";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lsp_implementations()<cr>";
    desc = "Find LSP Implementations";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>lt";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lsp_type_definitions<cr>";
    desc = "Find LSP Type Definitions";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>ls";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lsp_symbols()<cr>";
    desc = "Find LSP Symbols";
    mode = "n";
  }
  {
    __unkeyed = "<leader><space>lS";
    __unkeyed-1 = "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>";
    desc = "Find LSP Workspace Symbols";
    mode = "n";
  }
]
