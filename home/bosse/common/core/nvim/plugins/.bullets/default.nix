{
  programs.nixvim.plugins.bullets = {
    enable = true;
    settings = {
      enabled_file_types = [
        "markdown"
        "text"
        "gitcommit"
        "scratch"
      ];
    };
  };
}
