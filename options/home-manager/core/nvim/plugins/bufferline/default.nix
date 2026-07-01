{pkgs, ...}: {
  programs.nixvim.plugins.bufferline = {
    enable = true;
    package = pkgs.vimPlugins.bufferline-nvim;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    settings = {
      options = {
        mode = "buffers";
        themable = true;
        numbers = "none";
        padding = 0;
        close_command = null;
        right_mouse_command = null;
        left_mouse_command = null;
        middle_mouse_command = null;
        indicator.style = "none";
        buffer_close_icon = "";
        modified_icon = "●";
        close_icon = "";
        left_trunc_marker = "";
        right_trunc_marker = "";
        max_name_length = 18;
        max_prefix_length = 18;
        tab_size = 18;
        diagnostics = false;
        custom_areas.right = null;
        color_icons = true;
        show_buffer_icons = true;
        show_buffer_close_icons = false;
        show_close_icon = false;
        show_tab_indicators = true;
        persist_buffer_sort = true;
        always_show_bufferline = true;
        separator_style = [
          "│"
          "│"
        ];
        enforce_regular_tabs = false;
        hover.enabled = false;
      };
    };
  };
}
