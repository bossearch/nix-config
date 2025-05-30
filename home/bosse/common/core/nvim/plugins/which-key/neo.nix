[
  # Neo
  {
    __unkeyed = "<leader>n";
    group = "Neo";
    icon = " ";
    mode = "n";
  }
  {
    __unkeyed = "<leader>nf";
    __unkeyed-1 = "<cmd>enew<cr>";
    desc = "New File";
    mode = "n";
  }
  {
    __unkeyed = "<leader>nr";
    __unkeyed-1 = "<cmd>RootDir<cr>";
    desc = "Go To Root Directory";
    mode = "n";
  }
  {
    __unkeyed = "<leader>n.";
    __unkeyed-1 = "<cmd>LocalDir<cr>";
    desc = "Go To Local Directory";
    mode = "n";
  }
  {
    __unkeyed = "<leader>nn";
    __unkeyed-1 = "<cmd>cd ~/.nix-config<cr>";
    desc = "Go To Nix-config";
    mode = "n";
  }
  {
    __unkeyed = "<leader>ng";
    __unkeyed-1 = "<cmd>lua Snacks.lazygit()<cr>";
    desc = "Open LazyGit";
    mode = "n";
  }
  {
    __unkeyed = "<leader>nR";
    __unkeyed-1.__raw = ''
      function()
        Snacks.rename.rename_file()
      end
    '';
    desc = "Rename File";
    mode = "n";
  }
]
