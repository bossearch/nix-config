{
  programs.nixvim = {
    extraFiles = {
      "after/ftplugin/Fyler.lua".text = ''
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = true, nowait = true })
      '';
    };
  };
}
