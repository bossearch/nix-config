{
  programs.nixvim.plugins.lualine = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    luaConfig.pre = ''
      local palette = require("lib.util").get_colorScheme()
      local custom_lualine_theme = {
        normal = {
          a = { fg = palette.base00, bg = palette.base0D, gui = 'bold' },
          b = { fg = palette.base0D, bg = palette.base02 },
          c = { fg = palette.base05, bg = palette.base01 },
        },
        insert = {
          a = { fg = palette.base00, bg = palette.base0B, gui = 'bold' },
          b = { fg = palette.base0B, bg = palette.base02 },
        },
        visual = {
          a = { fg = palette.base00, bg = palette.base0E, gui = 'bold' },
          b = { fg = palette.base0E, bg = palette.base02 },
        },
        replace = {
          a = { fg = palette.base00, bg = palette.base08, gui = 'bold' },
          b = { fg = palette.base08, bg = palette.base02 },
        },
        command = {
          a = { fg = palette.base00, bg = palette.base0A, gui = 'bold' },
          b = { fg = palette.base0A, bg = palette.base02 },
        },
        inactive = {
          a = { fg = palette.base03, bg = palette.base00 },
          b = { fg = palette.base03, bg = palette.base00 },
          c = { fg = palette.base03, bg = palette.base01 },
        },
      }
    '';
    settings = {
      options = {
        theme.__raw = ''custom_lualine_theme'';
        globalstatus = true;
        disabled_filetypes = {statusline = ["dashboard" "alpha"];};
        section_separators = {
          left = "";
          right = "";
        };
        component_separators = {
          left = "│";
          right = "│";
        };
      };
      sections = {
        lualine_a = ["mode"];
        lualine_b.__raw = ''
          {
            "branch", {require("lib.util").get_cwd, icon = "󰝰"},
          }
        '';
        lualine_c.__raw = ''
          {
            {
              "buffers",
              show_filename_only = true,
              hide_filename_extension = true,
              max_length = vim.o.columns * 2 / 3,
            },
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
            },
          }
        '';
        lualine_x.__raw = ''
          {
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              color = { fg = palette.base09 },
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = { fg = palette.base0E },
            },
            -- {
            --   function()
            --     return " " .. require("dap").status()
            --   end,
            --   cond = function()
            --     return package.loaded["dap"] and require("dap").status() ~= ""
            --   end,
            --   color = { fg = palette.base08 },
            -- },
          }
        '';
        lualine_y = ["%l/%L:%c:%p%%" "filesize"];
        lualine_z.__raw = ''
          {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = "󰠠 ",
              },
              -- color = "lualine_c_normal",
              colored = false,
              update_in_insert = false,
            },
            { require("lib.util").lsp_status, icon = "" }
          }
        '';
      };
    };
  };
}
