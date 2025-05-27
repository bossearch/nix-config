{
  programs.nixvim.plugins.markdown-preview = {
    enable = true;
    settings = {
      auto_start = 0;
      auto_close = 1;
      theme = "dark";
      filetypes = ["markdown"];
      browser = "firefox";
    };
  };
}
