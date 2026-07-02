{pkgs, ...}: {
  plugins.lualine = {
    enable = true;
    package = pkgs.vimPlugins.lualine-nvim;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    luaConfig.pre = ''
      local p = _G.MiniBase16.config.palette
      -- ${pkgs.vimPlugins.lualine-nvim}
    '';
    settings = {
      options = {
        # theme.__raw = ''my_theme'';
        theme = "16color";
        globalstatus = true;
        disabled_filetypes = {statusline = ["dashboard" "alpha"];};
        section_separators = {
          left = "";
          right = "";
        };
        component_separators = {
          left = "";
          right = "";
        };
      };
      sections = {
        lualine_a = ["mode"];
        lualine_b = ["fileformat" "filesize" "encoding"];
        lualine_c.__raw = ''
          {
            {
              "diff",
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
              separator = '│',
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = "󰠠 ",
              },
              colored = true,
              update_in_insert = false,
              separator = '│',
            },
            -- {
            --   function()
            --     return " " .. require("dap").status()
            --   end,
            --   cond = function()
            --     return package.loaded["dap"] and require("dap").status() ~= ""
            --   end,
            --   color = { fg = palette.base08 },
            --   separator = '│',
            -- },
          }
        '';
        lualine_x.__raw = ''
          {
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              color = { fg = p.base09 },
              separator = '│',
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = { fg = p.base0E },
              separator = '│',
            },
          }
        '';
        lualine_y = ["%l/%L:%c:%p%%"];
        lualine_z.__raw = ''
          {
            {
              'lsp_status',
              icon = '',
              symbols = {
                spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                done = '✓',
                separator = ' ',
              },
              ignore_lsp = {},
              show_name = true,
            }
          }
        '';
      };
    };
  };
}
