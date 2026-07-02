{...}: {
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

    # oil
    {
      event = ["FileType"];
      pattern = ["oil"];
      callback.__raw = ''
        function()
          vim.keymap.set("n", "gd", function()
            detail = not detail
            if detail then
              require("oil").set_columns({ "icon", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
            vim.cmd("normal 0")
          end, { buffer = true })
          vim.keymap.set("n", "gi", function()
            icon = not icon
            if icon then
              vim.cmd("set foldcolumn=0")
              require("oil").set_columns({ "icon" })
            else
              vim.cmd("set foldcolumn=3")
              require("oil").set_columns({})
            end
            vim.cmd("normal 0")
          end, { buffer = true })
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
}
