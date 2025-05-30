{
  programs.nixvim.plugins = {
    luasnip = {
      enable = true;
      # lazyLoad = {
      #   settings = {
      #     lazy = true;
      #     event = ["VimEnter"];
      #   };
      # };
      # fromVscode = [{}];
    };
    friendly-snippets = {
      enable = true;
      autoLoad = true;
    };
  };
}
