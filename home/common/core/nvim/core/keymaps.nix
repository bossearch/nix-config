{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = [
      # buffers
      {
        key = "<S-h>";
        action.__raw = ''
          function()
            local buf = vim.api.nvim_get_current_buf()
            local ft = vim.bo[buf].filetype
            local ignore_filetypes = {
              "Fyler", "undotree", "Avante.*", "qf", "notify",
              "terminal", "toggleterm", "checkhealth" , "lspinfo",
            }
            for _, pattern in ipairs(ignore_filetypes) do
              if ft:match(pattern) then
                return
              end
            end
            vim.cmd("bprev")
          end
        '';
        options = {
          silent = true;
          noremap = true;
          desc = "Prev Buffer";
        };
      }
      {
        key = "<S-l>";
        action.__raw = ''
          function()
            local buf = vim.api.nvim_get_current_buf()
            local ft = vim.bo[buf].filetype
            local ignore_filetypes = {
              "Fyler", "undotree", "Avante.*", "qf", "notify",
              "terminal", "toggleterm", "checkhealth" , "lspinfo",
            }
            for _, pattern in ipairs(ignore_filetypes) do
              if ft:match(pattern) then
                return
              end
            end
            vim.cmd("bnext")
          end
        '';
        options = {
          silent = true;
          noremap = true;
          desc = "Next Buffer";
        };
      }
      # diagnostic
      {
        key = "<S-j>";
        action.__raw = ''
          function()
            vim.diagnostic.goto_next({float=false})
          end
        '';
        options = {
          silent = true;
          noremap = true;
          desc = "Next Diagnostic";
        };
      }
      {
        key = "<S-k>";
        action.__raw = ''
          function()
            vim.diagnostic.goto_prev({float=false})
          end
        '';
        options = {
          silent = true;
          noremap = true;
          desc = "Prev Diagnostic";
        };
      }
      # undo break-points
      {
        key = ",";
        action = ",<c-g>u";
        mode = "i";
      }
      {
        key = ".";
        action = ".<c-g>u";
        mode = "i";
      }
      {
        key = ";";
        action = ";<c-g>u";
        mode = "i";
      }
      # move lines
      {
        key = "<A-j>";
        action = "<cmd>execute 'move .+' . v:count1<cr>==";
        mode = "n";
      }
      {
        key = "<A-k>";
        action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
        mode = "n";
      }
      {
        key = "<A-j>";
        action = "<esc><cmd>m .+1<cr>==gi";
        mode = "i";
      }
      {
        key = "<A-k>";
        action = "<esc><cmd>m .-2<cr>==gi";
        mode = "i";
      }
      {
        key = "<A-j>";
        action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
        mode = "v";
      }
      {
        key = "<A-k>";
        action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
        mode = "v";
      }
      # better indent
      {
        key = "<";
        action = "<gv";
        mode = "v";
      }
      {
        key = ">";
        action = ">gv";
        mode = "v";
      }
      # insert(i) auto indent
      {
        key = "i";
        action.__raw = ''
          function()
            if #vim.fn.getline(".") == 0 then
              return [["_cc]]
            else
              return "i"
            end
          end
        '';
        mode = "n";
        options = {
          expr = true;
        };
      }
      # dd dont yank blank line to registers
      {
        key = "dd";
        action.__raw = ''
          function()
            if vim.api.nvim_get_current_line():match("^%s*$") then
              return '"_dd'
            else
              return "dd"
            end
          end
        '';
        mode = "n";
        options = {
          expr = true;
        };
      }
      # split
      {
        key = "-";
        action = "<C-W>s";
        mode = "n";
      }
      {
        key = "|";
        action = "<C-W>v";
        mode = "n";
      }
      # go to parent directory
      {
        key = "..";
        action = "<cmd>cd ..<cr>";
        mode = "n";
      }
      # disable s and S motions
      {
        key = "s";
        action = "<Nop>";
        mode = ["n" "v"];
        options = {
          silent = true;
          noremap = true;
        };
      }
      # References
      {
        key = "]]";
        action.__raw = ''
          function() Snacks.words.jump(vim.v.count1) end
        '';
        mode = "n";
        options = {
          desc = "Next References";
        };
      }
      {
        key = "[[";
        action.__raw = ''
          function() Snacks.words.jump(-vim.v.count1) end
        '';
        mode = "n";
        options = {
          desc = "Prev References";
        };
      }
      # sessions
      {
        key = "<C-s>";
        action.__raw = ''
          function()
            require("mini.sessions").write("global-session")
            print("Session saved!")
          end
        '';
        mode = ["n" "v" "i"];
        options = {
          silent = true;
          noremap = true;
          desc = "Prev Buffer";
        };
      }
      # terminal
      {
        key = "<C-t>";
        action = "<cmd>close<cr>";
        mode = "t";
      }
      # tmux-navigator
      {
        key = "<C-h>";
        action = "<cmd>TmuxNavigateLeft<cr>";
        mode = ["n" "v" "i"];
      }
      {
        key = "<C-j>";
        action = "<cmd>TmuxNavigateUp<cr>";
        mode = ["n" "v" "i"];
      }
      {
        key = "<C-k>";
        action = "<cmd>TmuxNavigateDown<cr>";
        mode = ["n" "v" "i"];
      }
      {
        key = "<C-l>";
        action = "<cmd>TmuxNavigateRight<cr>";
        mode = ["n" "v" "i"];
      }
    ];
  };
}
