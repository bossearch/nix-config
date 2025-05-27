{
  programs.nixvim.plugins.image = {
    enable = true;
    settings = {
      backend = "kitty";
      tmux_show_only_in_active_window = true;
      integrations = {
        markdown = {
          enable = true;
          only_render_image_at_cursor = true;
          filetypes = ["markdown"];
        };
      };
    };
  };
}
