{
  programs.nixvim.plugins.copilot-lua = {
    enable = false;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    settings = {
      panel.enabled = false;
      suggestion.enabled = false;
    };
  };
}
