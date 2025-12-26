{
  programs.nixvim = {
    autoCmd = [
      # Highlight on yank
      {
        event = ["TextYankPost"];
        pattern = ["*"];
        callback.__raw = ''
          function()
            vim.hl.on_yank()
          end
        '';
        desc = "Highlight selection on yank";
      }

      # Resize splits if window is resized
      {
        event = ["VimResized"];
        callback.__raw = ''
          function()
            vim.cmd("tabdo wincmd =")
          end
        '';
        desc = "Resize splits on window resize";
      }

      # Close some filetypes with <q>
      {
        event = ["FileType"];
        pattern = [
          "git"
          "help"
          "lspinfo"
          "man"
          "notify"
          "qf"
          "health"
          "oil"
        ];
        callback.__raw = ''
          function(event)
            vim.bo[event.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>q!<cr>", { buffer = event.buf, silent = true })
          end
        '';
        desc = "Close certain filetypes with <q>";
      }

      # Auto-create directory on save if necessary
      {
        event = ["BufWritePre"];
        callback.__raw = ''
          function(event)
            local file = vim.uv.fs_realpath(event.match) or event.match
            if vim.bo.filetype == "oil" then
              return
            end
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
        desc = "Auto-create directory before saving file";
      }

      # Remove trailing whitespace on save
      {
        event = ["BufWritePre"];
        pattern = ["*"];
        callback.__raw = ''
          function()
            local save_cursor = vim.fn.getpos(".")
            pcall(function() vim.cmd [[%s/\s\+$//e]] end)
            vim.fn.setpos(".", save_cursor)
          end
        '';
        desc = "Remove trailing whitespace on save";
      }

      # Set colorcolumn for git commit messages
      {
        event = ["FileType"];
        pattern = ["gitcommit"];
        callback.__raw = ''
          function()
            vim.opt_local.colorcolumn = { "50", "72" }
          end
        '';
        desc = "Set colorcolumn for git commit messages";
      }

      # Set custom hl for mini.base16
      {
        event = ["VimEnter"];
        callback.__raw = ''
          function()
            require("lib.util").set_highlights()
          end
        '';
      }

      # auto open fyler
      {
        event = ["BufWinEnter"];
        callback.__raw = ''
          function(args)
            local buf = args.buf or 0
            if vim.bo[buf].buftype ~= "" then
              return
            end

            local filename = vim.api.nvim_buf_get_name(buf)
            if filename == "" then
              return
            end

            local basename = vim.fn.fnamemodify(filename, ":t")
            local exclude_names = { ".hm.log", ".rb.log" }
            for _, name in ipairs(exclude_names) do
              if basename == name then return end
            end

            local ft = vim.bo[buf].filetype
            local ignore_filetypes = {
              "help", "gitcommit", "gitrebase", "gitconfig", "notify",
              "qf", "terminal", "toggleterm", "checkhealth", "lspinfo",
              "snacks_dashboard", "Avante.*", "dapui_.*"
            }
            for _, pattern in ipairs(ignore_filetypes) do
              if ft:match(pattern) then
                return
              end
            end

            for _, win in ipairs(vim.api.nvim_list_wins()) do
              local win_buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[win_buf].filetype == "Fyler" then
                return
              end
            end

            local file_win = vim.api.nvim_get_current_win()
            require("fyler").open({ dir = vim.fn.getcwd(), kind = "split_left" })

            if package.loaded["lib.util"] then
              require("lib.util").fyler_width(file_win)
            end
          end
        '';
      }

      # auto refresh fyler if dir change
      {
        event = ["DirChanged"];
        callback.__raw = ''
          function()
            local file_win = vim.api.nvim_get_current_win()
            require("fyler").open({ dir = vim.fn.getcwd(), kind = "split_left" })
            require("lib.util").fyler_width(file_win)
          end
        '';
      }

      # make qf split below others
      {
        event = ["FileType"];
        pattern = ["qf"];
        callback.__raw = ''
          function()
            vim.cmd("wincmd J")
          end
        '';
      }

      # hide undotree column
      {
        event = ["FileType"];
        pattern = ["undotree"];
        callback.__raw = ''
          function()
            vim.opt_local.signcolumn = "no"
            vim.opt_local.numberwidth = 1
          end
        '';
      }
    ];
  };
}
