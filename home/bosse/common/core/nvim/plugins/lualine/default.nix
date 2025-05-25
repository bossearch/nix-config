{
  programs.nixvim.plugins.lualine = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    settings = {
      inactive_sections = {
        # lualine_a = null;
        # lualine_b = null;
        lualine_c = ["filename"];
        lualine_x = ["location"];
        # lualine_y = null;
        # lualine_z = null;
      };
      options = {
        theme = "auto";
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
            {
              "branch"
            },
            {
              require("lib.util").get_cwd,
              icon = "󰝰",
              color = {
                fg = "#7aa2f7",
                bg = "#16161e"
              },
              separator= {
                right="│"
              }
            },
          }
        '';
        lualine_c.__raw = ''
          {
            {
              "buffers",
              show_filename_only = true,
              hide_filename_extension = true,
              -- max_length = vim.o.columns * 4 / 3,
              max_length = vim.o.columns * 2 / 3,
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
            },
          }
        '';
        lualine_x.__raw = ''
          {
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              color = { fg = "#ff9e64" },
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = { fg = "#bb9af7" },
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
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
            -- {
            --   function()
            --     return " " .. require("dap").status()
            --   end,
            --   cond = function()
            --     return package.loaded["dap"] and require("dap").status() ~= ""
            --   end,
            --   color = { fg = "#f7768e" },
            -- },
          }
        '';
        lualine_y = ["%l/%L:%c│%p%%"];
        lualine_z.__raw = ''
          { { require("lib.util").lsp_status, icon = "" } }
        '';
      };
    };
  };
}
