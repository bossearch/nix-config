{
  autoread = false; # Auto-load session if no file is given
  autowrite = true; # Auto-save session before exiting

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
      write = null;
      delete = null;
    };
    post = {
      read.__raw = ''
        function ()
          vim.notify("Session restored!")
        end
      '';
      write = null;
      delete = null;
    };
  };

  verbose = {
    read = false;
    write = true;
    delete = true;
  };
}
