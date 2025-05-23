{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    lazyLoad = {
      settings = {
        event = [ "BufReadPre" "BufNewFile" ];
      };
    };
    settings = {
      auto_insall = true;
      highlight.enable = true;
      incremental_selection = { enable = true; };
      indent.enable = true;
      textobjects.enable = true;
    };
  };
}
