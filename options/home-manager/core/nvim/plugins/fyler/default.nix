{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.fyler-nvim];
    extraConfigLua = ''
      require("fyler").setup({
        close_on_select = false,
        default_explorer = true,
        git_status = { enabled = false },
        track_current_buffer = true,
        icon = {
          directory_collapsed = "󰉋",
          directory_empty = "",
          directory_expanded  = "",
        },
        win = {
          kind_presets = {
            split_left = {
              width = "36abs",
            }
          }
        },
      })
    '';
  };
}
