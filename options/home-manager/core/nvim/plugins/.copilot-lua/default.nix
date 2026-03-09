{
  programs.nixvim.plugins.copilot-lua = {
    enable = true;
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
