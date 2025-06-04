{...}: {
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
      fg = "#c0caf5";
      "fg+" = "#B1BAE4";
      bg = "#1a1b26";
      "bg+" = "#16161e";
      hl = "#92BE67";
      "hl+" = "#93d84e";
      info = "#545c7e";
      marker = "#E26E87";
      prompt = "#AC8FE6";
      spinner = "#E26E87";
      pointer = "#E26E87";
      header = "#CEA265";
      gutter = "#1a1b26";
      border = "#27a1b9";
      separator = "#ff9e64";
      scrollbar = "#27a1b9";
      label = "#aeaeae";
      query = "#B1BAE4";
      preview-border = "#ff9e64";
      preview-scrollbar = "#ff9e64";
    };
  };
}
