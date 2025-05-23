{
  enabled = true;
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
