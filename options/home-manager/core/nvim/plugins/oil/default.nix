{
  programs.nixvim.plugins.oil = {
    enable = true;
    settings = {
      default_file_explorer = true;
      delete_to_trash = true;
      skip_confirm_for_simple_edits = true;
      view_options = {
        show_hidden = true;
      };
      preview_win = {
        update_on_cursor_moved = true;
        preview_method = "fast_scratch";
        disable_preview.__raw = ''
          function(filename)
            local file_size = vim.fn.getfsize(filename)
            return file_size > 100 * 1024
          end
        '';
        win_options = {
          wrap = false;
          signcolumn = "no";
          cursorcolumn = false;
          foldcolumn = "0";
          spell = false;
          list = false;
          #foldmethod = "indent";
        };
        keymaps.__raw = ''
          {
            ["g?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["|"] = { "actions.select", opts = { vertical = true } },
            ["-"] = { "actions.select", opts = { horizontal = true } },
            ["<C-t>"] = { "actions.select", opts = { tab = true } },
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = { "actions.close", mode = "n" },
            [".."] = { "actions.parent", mode = "n" },
            ["gr"] = "actions.refresh",
            ["gt"] = { "actions.toggle_trash", mode = "n" },
            ["H"] = { "actions.preview_scroll_left", mode = "n" },
            ["J"] = { "actions.preview_scroll_down", mode = "n" },
            ["K"] = { "actions.preview_scroll_up", mode = "n" },
            ["L"] = { "actions.preview_scroll_right", mode = "n" },
          }
        '';
        use_default_keymaps = false;
      };
    };
  };
}
