{
  config,
  hosts,
  mylib,
  ...
}: let
  base00 = "#${config.colorScheme.palette.base00}";
  base01 = "#${config.colorScheme.palette.base01}";
  base02 = "#${config.colorScheme.palette.base02}";
  base04 = "#${config.colorScheme.palette.base04}";
  base05 = "#${config.colorScheme.palette.base05}";
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base09 = "#${config.colorScheme.palette.base09}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0E = "#${config.colorScheme.palette.base0E}";
  base0F = "#${config.colorScheme.palette.base0F}";
  shell = hosts.shell;
in {
  imports = mylib.autoimport ./.;

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
      bg = base01;
      "bg+" = base00;
      hl = base0B;
      "hl+" = base0B;
      info = base02;
      marker = base08;
      prompt = base0E;
      spinner = base08;
      pointer = base08;
      header = base0A;
      gutter = base01;
      border = base0F;
      separator = base09;
      scrollbar = base0F;
      label = base04;
      query = base05;
      preview-border = base09;
      preview-scrollbar = base09;
    };
    enableBashIntegration = shell == "bash";
    enableFishIntegration = shell == "fish";
    enableZshIntegration = shell == "zsh";
  };
}
