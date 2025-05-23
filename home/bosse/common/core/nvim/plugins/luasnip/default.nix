{
  programs.nixvim.plugins.luasnip = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["VimEnter"];
      };
    };
    fromVscode = [{}];
  };
}
