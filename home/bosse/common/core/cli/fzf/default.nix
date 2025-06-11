{config, ...}: let
  base00 = "${config.lib.stylix.colors.withHashtag.base00}";
  base01 = "${config.lib.stylix.colors.withHashtag.base01}";
  base02 = "${config.lib.stylix.colors.withHashtag.base02}";
  base04 = "${config.lib.stylix.colors.withHashtag.base04}";
  base05 = "${config.lib.stylix.colors.withHashtag.base05}";
  base07 = "${config.lib.stylix.colors.withHashtag.base07}";
  base08 = "${config.lib.stylix.colors.withHashtag.base08}";
  base09 = "${config.lib.stylix.colors.withHashtag.base09}";
  base0A = "${config.lib.stylix.colors.withHashtag.base0A}";
  base0B = "${config.lib.stylix.colors.withHashtag.base0B}";
  base0E = "${config.lib.stylix.colors.withHashtag.base0E}";
  base0F = "${config.lib.stylix.colors.withHashtag.base0F}";
in {
  imports = [./extra];
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --color=auto";
    defaultOptions = [
      "--layout=reverse"
      "--height=50%"
      "--min-height=20"
      "--border=rounded"
      "--info=inline-right"
      "--prompt='❯ '"
      "--highlight-line"
      "--preview-window=right"
    ];
    colors = {
      fg = base07;
      "fg+" = base05;
      bg = base00;
      "bg+" = base01;
      hl = base0B;
      "hl+" = base0B;
      info = base02;
      marker = base08;
      prompt = base0E;
      spinner = base08;
      pointer = base08;
      header = base0A;
      gutter = base00;
      border = base0F;
      separator = base09;
      scrollbar = base0F;
      label = base04;
      query = base05;
      preview-border = base09;
      preview-scrollbar = base09;
    };
  };
}
