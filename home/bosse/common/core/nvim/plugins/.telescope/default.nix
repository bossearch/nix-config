{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      ui-select.enable = true;
    };
    settings = {
      defaults = {
        path_display = ["smart"];
        mappings = {
          i = {
            "|".__raw = "require('telescope.actions').select_vertical";
            "-".__raw = "require('telescope.actions').select_horizontal";
          };
        };
        prompt_prefix = "❯ ";
        selection_caret = "▌ ";
      };
      pickers = {
        find_files = {
          theme = "ivy";
          follow = true;
        };
        oldfiles = {
          theme = "ivy";
        };
        grep_string = {
          theme = "ivy";
        };
        help_tags = {
          theme = "ivy";
          previewer = false;
        };
        buffers = {
          theme = "ivy";
        };
        diagnostics = {
          theme = "ivy";
        };
      };
    };
  };
}
