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
          "DressingSelect"
          "fugitive"
          "git"
          "help"
          "lir"
          "lspinfo"
          "man"
          "notify"
          "qf"
          "telescope"
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
            -- Get the file path
            local file = vim.uv.fs_realpath(event.match) or event.match
            -- Skip if the file is managed by oil.nvim (you can also check for filetype)
            if vim.bo.filetype == "oil" then
              return
            end
            -- Create the directory if necessary
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

      # Remove ro from format options
      {
        event = ["FileType"];
        pattern = ["*"];
        callback.__raw = ''
          function()
            vim.opt_local.formatoptions:remove({ 'r', 'o' })
          end
        '';
        desc = "Remove ro from format options";
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
    ];
  };
}
