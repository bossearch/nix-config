{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    lazyLoad = {
      settings = {
        event = [ "BufReadPre" "BufNewFile" ];
      };
    };
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
  };
}
