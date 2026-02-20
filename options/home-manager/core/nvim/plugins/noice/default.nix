{
  programs.nixvim = {
    extraConfigLua = ''
      vim.deprecate = function() end
    '';
    plugins.noice = {
      enable = true;
      settings = {
        cmdline = {
          view = "cmdline"; # cmdline_popup, cmdline
          format = {
            conceal = false;
          };
        };
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
          command_palette = true; # position the cmdline and popupmenu together
          long_message_to_split = true; # long messages will be sent to a split
        };
        views = {
          cmdline_popup = {
            position = {
              row = "50%";
              col = "50%";
            };
          };
        };
      };
    };
  };
}
