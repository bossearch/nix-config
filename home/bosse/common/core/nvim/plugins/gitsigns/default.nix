{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    settings = {
      current_line_blame = true;
      current_line_blame_formatter = "   <author>, <committer_time:%R> • <summary>";
    };
  };
}
