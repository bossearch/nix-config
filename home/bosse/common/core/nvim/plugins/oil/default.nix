{
  programs.nixvim.plugins.oil = {
    enable = true;
    settings = {
      default_file_explorer = true;
      delete_to_trash = true;
      skip_confirm_for_simple_edits = true;
      view_options = {
        show_hidden = true;
      };
      preview_win = {
        update_on_cursor_moved = true;
      };
      float = {
        max_height.__raw = ''0.8'';
        max_width.__raw = ''0.8'';
      };
    };
  };
}
