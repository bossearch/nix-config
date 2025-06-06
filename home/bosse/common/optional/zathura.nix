{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-keephue = true;
      default-bg = "#1a1b26";
      default-fg = "#c0caf5";
      statusbar-bg = "#24283b";
      statusbar-fg = "#c0caf5";
      inputbar-bg = "#1a1b26";
      inputbar-fg = "#7aa2f7";
      notification-bg = "#1a1b26";
      notification-fg = "#9ece6a";
      notification-error-bg = "#1a1b26";
      notification-error-fg = "#f7768e";
      notification-warning-bg = "#1a1b26";
      notification-warning-fg = "#e0af68";
      highlight-color = "rgba(122, 162, 247, 0.5)"; # 7aa2f7
      highlight-active-color = "rgba(224, 175, 104, 0.5)"; # e0af68
      completion-bg = "#24283b";
      completion-fg = "#c0caf5";
      completion-highlight-bg = "#1a1b26";
      completion-highlight-fg = "#7aa2f7";
      recolor-lightcolor = "#16161e";
      recolor-darkcolor = "#c0caf5";
    };
    mappings = {
      h = "navigate previous";
      j = "zoom out";
      k = "zoom in";
      l = "navigate next";
      H = "scroll left";
      J = "scroll down";
      K = "scroll up";
      L = "scroll right";
      R = "rotate";
      r = "reload";
      i = "recolor";
      p = "print";
    };
  };
}
