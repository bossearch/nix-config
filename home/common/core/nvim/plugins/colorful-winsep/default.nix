{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.colorful-winsep];
    extraConfigLua = ''
      require("colorful-winsep").setup({
        hi = {
          fg = require("lib.util").get_colorScheme().base0F
        },
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
        symbols = { "─", "│", "┌", "┐", "└", "┘" },
        -- #70: https://github.com/nvim-zh/colorful-winsep.nvim/discussions/70
        only_line_seq = false,
        -- Smooth moving switch
        smooth = false,
        exponential_smoothing = false,

        anchor = {
          left = { height = 1, x = -1, y = -1 },
          right = { height = 1, x = -1, y = 0 },
          up = { width = 0, x = -1, y = 0 },
          bottom = { width = 0, x = 1, y = 0 },
        },
      })
    '';
  };
}
