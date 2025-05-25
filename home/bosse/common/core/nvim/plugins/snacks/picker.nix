{
  formatters = {
    file = {
      filename_first = true;
      truncate = 80;
    };
  };
  matcher = {
    frecency = true;
  };
  layout = {
    preset = "custom";
  };
  win = {
    input = {
      keys.__raw = ''
        {
          ["J"] = { "preview_scroll_down", mode = { "i", "n" } };
          ["K"] = { "preview_scroll_up", mode = { "i", "n" } };
          ["H"] = { "preview_scroll_left", mode = { "i", "n" } };
          ["L"] = { "preview_scroll_right", mode = { "i", "n" } };
          ["-"] = { "edit_split", mode = "n" },
          ["|"] = { "edit_vsplit", mode = "n" },
        }
      '';
    };
  };
  sources = {
    explorer = {
      win = {
        input = {
          keys.__raw = ''
            {
              ["<c-h>"] = { function() vim.cmd("TmuxNavigateRight") end, mode = "i" },
              ["<c-j>"] = { function() vim.cmd("TmuxNavigateDown") end, mode = "i" },
              ["<c-k>"] = { function() vim.cmd("TmuxNavigateUp") end, mode = "i" },
              ["<c-l>"] = { function() vim.cmd("TmuxNavigateLeft") end, mode = "i" },
            }
          '';
        };
        list = {
          keys.__raw = ''
            {
              ["<leader>/"] = { "close", mode = { "i", "n" } },
              ["-"] = { "edit_split", mode = { "i", "n" } },
              ["|"] = { "edit_vsplit", mode = { "i", "n" } },
            }
          '';
        };
      };
    };
  };
  layouts = {
    custom = {
      layout.__raw = ''
        {
          box = "vertical",
          backdrop = true,
          row = -1,
          width = 0,
          height = 0.39,
          border = "top",
          title = " {title} {live} {flags}",
          title_pos = "center",
          {
            win = "input",
            height = 1,
            border = "bottom"
          },
          {
            box = "horizontal",
            {
              win = "list",
              border = "none",
            },
            {
              win = "preview",
              title = "{preview}",
              width = 0.5,
              border = "left"
            },
          },
        }
      '';
    };
    vscode = {
      layout.__raw = ''
        {
          backdrop = false,
          row = 20,
          width = 0.4,
          min_width = 80,
          height = 0.4,
          border = "none",
          box = "vertical",
          {
            win = "input",
            height = 1,
            border = "rounded",
            title = "{title} {live} {flags}",
            title_pos = "center"
          },
          {
            win = "list",
            border = "hpad"
          },
          {
            win = "preview",
            title = "{preview}",
            border = "rounded"
          },
        }
      '';
    };
  };
}
