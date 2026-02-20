[
  {
    __unkeyed = "<leader>a";
    group = "Avante";
    icon = "󰭻 ";
    mode = ["n" "v"];
  }
  {
    __unkeyed = "<leader><cr>";
    group = "Siuu";
    icon = "󰌑 ";
    mode = "n";
  }
  {
    __unkeyed = "<leader><cr>/";
    __unkeyed-1.__raw = ''
      function()
        local file_win = vim.api.nvim_get_current_win()
        require("fyler").open({ dir = vim.fn.getcwd(), kind="split_left" })
        require("lib.util").fyler_width(file_win)
      end
    '';
    desc = "Toggle Explorer";
    mode = "n";
  }
  {
    __unkeyed = "<leader><cr>f";
    __unkeyed-1.__raw = ''
      function()
        local fyler = require("fyler")

        local had_split = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local cfg = vim.api.nvim_win_get_config(win)
          if cfg.relative == "" and vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "Fyler" then
            had_split = true
            break
          end
        end

        local file_win = vim.api.nvim_get_current_win()
        fyler.open({ dir = vim.fn.getcwd(), kind = "float" })

        vim.defer_fn(function()
          local float_win
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local cfg = vim.api.nvim_win_get_config(win)
            if cfg.relative ~= "" and vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "Fyler" then
              float_win = win
              break
            end
          end
          if not float_win then return end

          vim.api.nvim_create_autocmd("WinClosed", {
            once = true,
            pattern = tostring(float_win),
            callback = function()
              if had_split then
                fyler.open({ dir = vim.fn.getcwd(), kind = "split_left" })
                require("lib.util").fyler_width(file_win)
              end
            end,
          })
        end, 10)
      end
    '';
    desc = "Toggle Floating Explorer";
    mode = "n";
  }
  {
    __unkeyed = "<leader><CR><CR>";
    __unkeyed-1.__raw = ''
      function()
        require("snacks").terminal.toggle(nil, {
          win = {
            height = 0.16,
            wo = { winbar = "" }
          },
          cwd = vim.fn.getcwd(),
        })
      end
    '';
    desc = "Toggle Terminal";
    mode = "n";
  }
]
