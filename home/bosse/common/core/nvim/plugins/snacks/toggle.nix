{
  programs.nixvim = {
    extraConfigLua = ''
      local Snacks = require("snacks")
      -- snacks
      Snacks.toggle.zen():map("<leader>tz")
      Snacks.toggle.zoom():map("<leader>tm")
      Snacks.toggle.dim():map("<leader>tD")
      Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
      Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
      Snacks.toggle.diagnostics():map("<leader>td")
      Snacks.toggle.indent():map("<leader>ti")

      if vim.lsp.inlay_hint then
        Snacks.toggle.inlay_hints():map("<leader>th")
      end

      -- conform
      Snacks.toggle({
        name = "Autoformat on Save",
        get = function()
          return not vim.g.disable_autoformat
        end,
        set = function(state)
          vim.g.disable_autoformat = not state
          vim.b.disable_autoformat = not state
        end,
      }):map("<leader>tf")

      -- render markdown
      Snacks.toggle({
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map("<leader>mr")

      -- treesitter-context
      Snacks.toggle({
        name = "Treesitter Context",
        get = require("treesitter-context").enabled,
        set = function(state)
          if state then
            require("treesitter-context").enable()
          else
            require("treesitter-context").disable()
          end
        end,
      }):map("<leader>tc")

      -- mini.pairs
      Snacks.toggle({
        name = "Mini Pairs",
        get = function()
          return not vim.g.minipairs_disable
        end,
        set = function(state)
          vim.g.minipairs_disable = not state
        end,
      }):map("<leader>tp")

      -- mini.splitjoin
      Snacks.toggle({
        name = "Split/Join",
        get = function()
          return false -- always false, no state
        end,
        set = function(_)
          require("mini.splitjoin").toggle()
        end,
      }):map("<leader>tj")

      -- gitsigns
      Snacks.toggle({
        name = "Git Gutter",
        get = function()
          return require("gitsigns.config").config.signcolumn
        end,
        set = function(state)
          require("gitsigns").toggle_signs(state)
        end,
      }):map("<leader>gg")

      Snacks.toggle({
        name = "Git Deleted",
        get = function()
          return require("gitsigns.config").config.signs.show_deleted
        end,
        set = function(state)
          -- only toggle if needed, since toggle_deleted() is non-idempotent
          local conf = require("gitsigns.config").config.signs.show_deleted
          if conf ~= state then
            require("gitsigns").toggle_deleted()
          end
        end,
      }):map("<leader>gD")

      -- outline
      Snacks.toggle({
        name = "Symbols Outline",
        get = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].filetype == "Outline" and vim.api.nvim_buf_is_loaded(buf) then
              return true
            end
          end
          return false
        end,
        set = function(state)
          if state then
            require("outline").open()
          else
            require("outline").close()
          end
        end,
      }):map("<leader>to")

      -- notify
      Snacks.toggle({
        notify = false,
        name = "Notification History",
        get = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[buf].filetype == "snacks_notif_history" and vim.api.nvim_buf_is_loaded(buf) then
              return true
            end
          end
          return false
        end,
        set = function(state)
          if state then
            require("snacks").notifier.show_history()
          else
            require("snacks").notifier.show_history()
          end
        end,
      }):map("<leader>tn")
    '';
  };
}
