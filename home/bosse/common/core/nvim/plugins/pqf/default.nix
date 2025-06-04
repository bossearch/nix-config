{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.nvim-pqf];
    extraConfigLua = ''
      require("pqf").setup({
          signs = {
          error = { text = ' ', hl = 'DiagnosticSignError' },
          warning = { text = ' ', hl = 'DiagnosticSignWarn' },
          info = { text = '󰠠 ', hl = 'DiagnosticSignInfo' },
          hint = { text = ' ', hl = 'DiagnosticSignHint' },
        },
        show_multiple_lines = false,
        max_filename_length = 0,
        filename_truncate_prefix = '[...]',
      })
    '';
  };
}
