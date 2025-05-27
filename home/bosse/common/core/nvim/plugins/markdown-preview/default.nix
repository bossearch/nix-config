{
  programs.nixvim.plugins.markdown-preview = {
    enable = true;
    settings = {
      auto_start = 0;
      auto_close = 0;
      combine_preview = 0;
      combine_preview_auto_refresh = 0;
      theme = "dark";
      filetypes = ["markdown"];
      browser = "firefox";
    };
  };
}
