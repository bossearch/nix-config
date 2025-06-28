{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["BufReadPre" "BufNewFile"];
      };
    };
    settings = {
      signs = {
        add = {text = "+";};
        change = {text = "~";};
        delete = {
          text = "-";
          show_count = true;
        };
        topdelete = {text = "‾";};
        changedelete = {text = "≃";};
        untracked = {text = "?";};
      };
      signs_staged_enable = false;

      current_line_blame = true;
      current_line_blame_formatter = " <author>, <committer_time:%R> • <summary>";
    };
  };
}
