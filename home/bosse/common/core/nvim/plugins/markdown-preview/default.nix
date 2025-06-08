{
  programs.nixvim.plugins.markdown-preview = {
    enable = true;
    settings = {
      auto_start = 0;
      auto_close = 0;
      browser = "firefox";
      combine_preview = 1;
      combine_preview_auto_refresh = 1;
      filetypes = ["markdown"];
      theme = "dark";
    };
  };
}
