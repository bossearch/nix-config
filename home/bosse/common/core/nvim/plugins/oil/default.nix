{
  programs.nixvim.plugins.oil = {
    enable = true;
    settings = {
      default_file_explorer = true;
      delete_to_trash = true;
      skip_confirm_for_simple_edits = false;
      view_options = {
        show_hidden = true;
        is_always_hidden.__raw = ''
          function(name, _)
            local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
            return vim.tbl_contains(folder_skip, name)
          end
        '';
      };
      preview_win = {
        update_on_cursor_moved = true;
      };
      win_options = {
        winbar.__raw = ''
          "%!v:lua.require('lib.util').get_oil_winbar()"
        '';
      };
    };
  };
}
