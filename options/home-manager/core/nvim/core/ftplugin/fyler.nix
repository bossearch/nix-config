{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/fyler.lua".text = ''
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = true, nowait = true })
      '';
    };
  };
}
