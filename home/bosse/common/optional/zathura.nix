{config, ...}: let
  base00 = "${config.lib.stylix.colors.withHashtag.base00}";
  base01 = "${config.lib.stylix.colors.withHashtag.base01}";
  base02 = "${config.lib.stylix.colors.withHashtag.base02}";
  base07 = "${config.lib.stylix.colors.withHashtag.base07}";
  base08 = "${config.lib.stylix.colors.withHashtag.base08}";
  base0A = "${config.lib.stylix.colors.withHashtag.base0A}";
  base0B = "${config.lib.stylix.colors.withHashtag.base0B}";
  base0D = "${config.lib.stylix.colors.withHashtag.base0D}";
  palette = config.lib.stylix.colors;
  base0A-rgba = "rgba(${palette.base0A-rgb-r}, ${palette.base0A-rgb-g}, ${palette.base0A-rgb-b}, 0.5)";
  base0D-rgba = "rgba(${palette.base0D-rgb-r}, ${palette.base0D-rgb-g}, ${palette.base0D-rgb-b}, 0.5)";
in {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-keephue = true;
      default-bg = base00;
      default-fg = base07;
      statusbar-bg = base02;
      statusbar-fg = base07;
      inputbar-bg = base00;
      inputbar-fg = base0D;
      notification-bg = base00;
      notification-fg = base0B;
      notification-error-bg = base00;
      notification-error-fg = base08;
      notification-warning-bg = base00;
      notification-warning-fg = base0A;
      highlight-color = base0D-rgba;
      highlight-active-color = base0A-rgba;
      completion-bg = base02;
      completion-fg = base07;
      completion-highlight-bg = base00;
      completion-highlight-fg = base0D;
      recolor-lightcolor = base01;
      recolor-darkcolor = base07;
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
