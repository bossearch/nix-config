{...}: {
  plugins.highlight-colors = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    settings = {
      render = "background";
      enable_hex = true;
      enable_short_hex = true;
      enable_rgb = true;
      enable_hsl = true;
      enable_ansi = true;
      enable_xterm256 = true;
      enable_xtermTrueColor = true;
      enable_hsl_without_function = true;
      enable_var_usage = true;
      enable_named_colors = true;
      enable_tailwind = true;
      exclude_filetypes = null;
      exclude_buftypes = null;
    };
  };
}
