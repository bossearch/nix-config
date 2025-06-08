{
  programs.nixvim.plugins.flash = {
    enable = true;
    settings = {
      highlight = {
        backdrop = false;
        matches = false;
      };
      modes = {
        char = {
          jump_labels = true;
          highlight = {backdrop = false;};
        };
      };
      prompt = {
        enabled = false;
      };
    };
    luaConfig.post = ''
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
        require('flash').jump()
      end, { desc = 'Flash jump forward' })
    '';
  };
}
