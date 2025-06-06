{
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      recolor-keephue = true;
      default-bg = "#1a1b26";
      default-fg = "#c0caf5";
      statusbar-fg = "#c0caf5";
      statusbar-bg = "#24283b";
      inputbar-bg = "#1a1b26";
      inputbar-fg = "#7aa2f7";
      notification-bg = "#1a1b26";
      notification-fg = "#7aa2f7";
      notification-error-bg = "#1a1b26";
      notification-error-fg = "#f7768e";
      notification-warning-bg = "#1a1b26";
      notification-warning-fg = "#f7768e";
      highlight-color = "#e0af68";
      highlight-active-color = "#9aa5ce";
      completion-bg = "#24283b";
      completion-fg = "#c0caf5";
      completion-highlight-fg = "#9aa5ce";
      completion-highlight-bg = "24283b";
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
