{...}: {
  plugins.noice = {
    enable = true;
    settings = {
      cmdline = {
        enabled = true;
        view = "cmdline"; # cmdline_popup, cmdline
      };
      notify.enabled = false;
      popupmenu.enabled = false;
      routes.__raw = ''
        {
          {
            filter = {
              event = "msg_show",
              any = {
                { find = "%d+L, %d+B" },
                { find = "; after #%d+" },
                { find = "; before #%d+" },
              },
            },
            view = "mini",
          }
        }
      '';
      presets = {
        bottom_search = false; # use a classic bottom cmdline for search
        command_palette = false; # position the cmdline and popupmenu together
        long_message_to_split = true; # long messages will be sent to a split
      };
    };
  };
}
