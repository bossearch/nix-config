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
            columns = {
              git = { enabled = true },
              diagnostic = { enabled = false },
            },
            columns_order = { "diagnostic", "git" },
            default_explorer = true,
            delete_to_trash = true,
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
