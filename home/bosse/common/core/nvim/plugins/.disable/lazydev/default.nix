{
  programs.nixvim.plugins.lazydev = {
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    enable = true;
  };
}
