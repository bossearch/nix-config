{pkgs, ...}: {
  programs.nixvim.plugins.lualine = {
    enable = true;
    package = pkgs.vimPlugins.lualine-nvim;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    luaConfig.pre = ''
      local p = _G.MiniBase16.config.palette
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
              show_filename_only = false,
              hide_filename_extension = false,
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
              color = { fg = p.base09 },
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = { fg = p.base0E },
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
        lualine_y = ["%l/%L:%c:%p%%" "filesize" "encoding"];
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
