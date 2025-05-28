{
  programs.nixvim.plugins.image = {
    enable = true;
    settings = {
      backend = "kitty";
      tmux_show_only_in_active_window = true;
      hijack_file_patterns = [
        "*.png"
        "*.jpg"
        "*.jpeg"
        "*.gif"
        "*.webp"
        "*.avif"
      ];
      max_width_window_percentage = 50;
      max_height_window_percentage = 50;
      window_overlap_clear_enabled = false;
      window_overlap_clear_ft_ignore = [
        "cmp_menu"
        "cmp_docs"
        ""
      ];
      integrations = {
        markdown = {
          enabled = true;
          only_render_image_at_cursor = true;
          filetypes = ["markdown"];
        };
      };
    };
  };
}
