{
  autoread = false;
  autowrite = false;

  directory.__raw = ''vim.fn.stdpath ("state") .. "/session"'';
  file = "";

  force = {
    read = true;
    write = true;
    delete = true;
  };

  hooks = {
    pre = {
      delete = null;
      read = null;
      write = null;
    };
    post = {
      delete = null;
      read.__raw = ''
        function(data)
          vim.schedule(function()
            vim.notify(data.name .. " restored")
          end)
        end,

      '';
      write = null;
    };
  };

  verbose = {
    read = false;
    write = true;
    delete = true;
  };
}
