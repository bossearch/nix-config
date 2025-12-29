{
  autoread = false; # Auto-load session if no file is given
  autowrite = false; # Auto-save session before exiting

  directory.__raw = ''vim.fn.stdpath ("state") .. "/session"''; # ~/.local/state/nvim/session
  file = ""; # Save session as 'Session.vim' inside the directory

  force = {
    read = true;
    write = true;
    delete = true;
  };

  hooks = {
    pre = {
      read = null;
      write.__raw = ''
        function ()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_get_name(buf):match("^fyler://") then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end
      '';
      delete = null;
    };
    post = {
      read.__raw = ''
        function ()
          vim.notify("Session restored!")
        end
      '';
      write.__raw = ''
        function()
          local file_win = vim.api.nvim_get_current_win()
          require("fyler").open({ dir = vim.fn.getcwd(), kind="split_left" })
          require("lib.util").fyler_width(file_win)
        end
      '';
      delete = null;
    };
  };

  verbose = {
    read = false;
    write = true;
    delete = true;
  };
}
