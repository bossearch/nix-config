{
  programs.nixvim = {
    userCommands = {
      CopyRelativePath = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%")
              require("lib.util").copy_to_clipboard(path, 'Copied "' .. path .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      CopyAbsolutePath = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%:p")
              require("lib.util").copy_to_clipboard(path, 'Copied "' .. path .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      CopyRelativePathWithLine = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%")
              local line = vim.fn.line(".")
              local result = path .. ":" .. line
              require("lib.util").copy_to_clipboard(result, 'Copied "' .. result .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      CopyAbsolutePathWithLine = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%:p")
              local line = vim.fn.line(".")
              local result = path .. ":" .. line
              require("lib.util").copy_to_clipboard(result, 'Copied "' .. result .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      CopyFileName = {
        command = {
          __raw = ''
            function()
              local path = vim.fn.expand("%:t")
              require("lib.util").copy_to_clipboard(path, 'Copied "' .. path .. '" to the clipboard!')
            end, {}
          '';
        };
      };
      RootDir = {
        command = {
          __raw = ''
            function()
              local root = require("lib.util").get_root_dir()
              if root == "" then
                return
              end
              vim.cmd("lcd " .. root)
            end, {}
          '';
        };
      };
      LocalDir = {
        command = {
          __raw = ''
            function()
              local bufname = vim.fn.expand('%:p')
              if vim.fn.filereadable(bufname) == 0 then
                return
              end

              local file_dir = vim.fn.fnamemodify(bufname, ':h')
              vim.cmd("lcd " .. vim.fn.fnameescape(file_dir))
            end, {}
          '';
        };
      };
      ReloadTheme = {
        command = {
          __raw = ''
            function()
              package.loaded["lib.util"] = nil
              local palette = require("lib.util").get_colorScheme()
              -- Reapply mini.base16 theme
              require("mini.base16").setup({ palette = palette })

              -- Reapply Lualine
              local custom_lualine_theme = {
                normal = {
                  a = { fg = palette.base00, bg = palette.base0D, gui = "bold" },
                  b = { fg = palette.base0D, bg = palette.base02 },
                  c = { fg = palette.base05, bg = palette.base01 },
                },
                insert = {
                  a = { fg = palette.base00, bg = palette.base0B, gui = "bold" },
                  b = { fg = palette.base0B, bg = palette.base02 },
                },
                visual = {
                  a = { fg = palette.base00, bg = palette.base0E, gui = "bold" },
                  b = { fg = palette.base0E, bg = palette.base02 },
                },
                replace = {
                  a = { fg = palette.base00, bg = palette.base08, gui = "bold" },
                  b = { fg = palette.base08, bg = palette.base02 },
                },
                command = {
                  a = { fg = palette.base00, bg = palette.base0A, gui = "bold" },
                  b = { fg = palette.base0A, bg = palette.base02 },
                },
                inactive = {
                  a = { fg = palette.base03, bg = palette.base00 },
                  b = { fg = palette.base03, bg = palette.base00 },
                  c = { fg = palette.base03, bg = palette.base01 },
                },
              }
              require("lualine").setup({
                options = {
                  theme = custom_lualine_theme,
                },
                sections = {
                  lualine_x = {
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
                   },
                 },
              })

              -- Reapply colorful-winsep (not work)
              require("colorful-winsep").setup({
                hi = {
                  fg = palette.base0F
                },
              })

              -- Reapply other thing
              require("lib.util").set_highlights()
            end, {}
          '';
        };
      };
    };
  };
}
