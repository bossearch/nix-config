{
  programs.nixvim.plugins.yazi = {
    enable = true;
    lazyLoad = {
      settings = {
        cmd = "Yazi";
        event = "UIEnter";
      };
    };
    settings = {
      floating_window_scaling_factor = 1;
      keymaps = {
        show_help = "<f1>";
        open_file_in_vertical_split = "|";
        open_file_in_horizontal_split = "-";
      };
      hooks.__raw = ''
      {
        yazi_closed_successfully = function(chosen_file, config, state)
          if chosen_file == nil and state.last_directory.filename then
            vim.notify("Changing directory to " .. state.last_directory.filename)
            vim.fn.chdir(state.last_directory.filename)
          end
        end
      }
      '';
    };
  };
}
