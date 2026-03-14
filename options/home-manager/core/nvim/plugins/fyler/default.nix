{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.fyler-nvim];
    extraConfigLua = ''
      require("fyler").setup({
        integrations = {
          icon = "mini_icons",
        },
        views = {
          finder = {
            win = {
              border = "rounded",
              kind = "split_left",
              kinds = {
                ["split_left"] = {
                  width = "36",
                  win_opts = {
                    winfixwidth = true,
                    number = true,
                    relativenumber = true,
                  },
                },
              },
            },
            close_on_select = false,
            default_explorer = true,
            columns_order = { "diagnostic", "git" },
            columns = {
              git = { enabled = true },
              diagnostic = { enabled = false },
            },
            follow_current_file = true,
            icon = {
              directory_collapsed = "󰉋",
              directory_empty = "",
              directory_expanded = "",
            },
          },
        },
      })
    '';
  };
}
