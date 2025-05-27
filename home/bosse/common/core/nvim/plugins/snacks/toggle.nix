{
  programs.nixvim = {
    extraConfigLua = ''
      -- zen mode
      require("snacks").toggle.zen():map("<leader>wz")

      -- render markdown
      require("snacks").toggle({
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
      require("snacks").toggle({
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

      -- gitsigns
      require("snacks").toggle({
        name = "Git Gutter",
        get = function()
          return require("gitsigns.config").config.signcolumn
        end,
        set = function(state)
          require("gitsigns").toggle_signs(state)
        end,
      }):map("<leader>gg")

      require("snacks").toggle({
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
    '';
  };
}
