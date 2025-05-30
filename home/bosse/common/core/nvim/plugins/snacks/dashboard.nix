{
  enabled = true;
  formats = {
    file.__raw = ''
      function(item, ctx)
        local path = vim.fn.fnamemodify(item.file, ":~")
        local width = (ctx.width or 80) - 4

        if #path <= width then
          local dir = vim.fn.fnamemodify(path, ":h")
          local file = vim.fn.fnamemodify(path, ":t")
          return { { dir .. "/", hl = "dir" }, { file, hl = "file" } }
        end

        local filename = vim.fn.fnamemodify(path, ":t")
        local parent = vim.fn.fnamemodify(vim.fn.fnamemodify(path, ":h"), ":t")
        local base = vim.fn.fnamemodify(path, ":h:h")
        local parts = vim.split(base, "/")

        table.insert(parts, parent)
        table.insert(parts, filename)

        for i = 2, #parts - 2 do
          for j = 2, i do
            parts[j] = parts[j]:sub(1, 1)
          end
          local trial = table.concat(parts, "/")
          if #trial <= width then
            local dir = table.concat(vim.list_slice(parts, 1, #parts - 1), "/")
            return { { dir .. "/", hl = "dir" }, { parts[#parts], hl = "file" } }
          end
        end

        local short = "…" .. filename:sub(-math.max(1, width - #parent - 3))
        return { { parent .. "/", hl = "dir" }, { short, hl = "file" } }
      end
    '';
  };
  sections = [
    {
      pane = 1;
      section = "header";
    }
    {
      icon = " ";
      title = "Recent Files\n";
      section = "recent_files";
      limit = 10;
      gap = 1;
      indent = 2;
      padding = 1;
    }
    {
      icon = " ";
      title = "Projects\n";
      section = "projects";
      limit = 5;
      gap = 1;
      indent = 2;
      padding = 1;
      pick = true;
      session = false;
    }
    {
      section = "keys";
      padding = 2;
    }
    {
      align = "center";
      text.__raw = ''
        {
          { require("lib.util").get_tips(), hl = "header"},
          {"\n\n  ", hl = "desc"},
          {"Nixvim started in ", hl = "footer"},
          { require("lib.util").get_nvim_startup_time(), hl = "key"},
        }
      '';
    }
  ];
  preset = {
    keys = [
      {
        icon = " ";
        key = "s";
        desc = "Restore Session";
        action = ":lua MiniSessions.read('global-session')";
        padding = 1;
      }
      {
        icon = " ";
        key = "q";
        desc = "Quit";
        action = ":qa";
      }
    ];
    header = ''
      ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
      ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
      ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
    '';
  };
}
