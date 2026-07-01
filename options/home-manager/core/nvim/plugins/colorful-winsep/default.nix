{
  programs.nixvim.plugins.colorful-winsep = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    settings = {
      excluded_ft = [];
      border = [
        "─"
        "│"
        "┌"
        "┐"
        "└"
        "┘"
      ];
      animate.enabled = false;
      anchor = {
        left = {
          height = 1;
          x = -1;
          y = -1;
        };
        right = {
          height = 1;
          x = -1;
          y = 0;
        };
        up = {
          width = 0;
          x = -1;
          y = 0;
        };
        bottom = {
          width = 0;
          x = 1;
          y = 0;
        };
      };
      indicator_for_2wins.position = false;
    };
  };
}
