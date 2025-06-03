{...}: {
  imports = [./extra];
  # home.file.".config/fzf/.fzfrc" = {
  #   text = ''
  #     --layout=reverse
  #     --height=50%
  #     --min-height=20
  #     --border=rounded
  #     --info=inline-right
  #     --prompt="❯ "
  #     --highlight-line
  #     --preview-window=right
  #     --color=fg:#c0caf5
  #     --color=fg+:#B1BAE4
  #     --color=bg:#1a1b26
  #     --color=bg+:#16161e
  #     --color=hl:#92BE67
  #     --color=hl+:#93d84e
  #     --color=info:#545c7e
  #     --color=marker:#E26E87
  #     --color=prompt:#AC8FE6
  #     --color=spinner:#E26E87
  #     --color=pointer:#E26E87
  #     --color=header:#CEA265
  #     --color=gutter:#1a1b26
  #     --color=border:#27a1b9
  #     --color=separator:#ff9e64
  #     --color=scrollbar:#27a1b9
  #     --color=label:#aeaeae
  #     --color=query:#B1BAE4
  #     --color=preview-border:#ff9e64
  #     --color=preview-scrollbar:#ff9e64
  #   '';
  # };
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --hidden --color always";
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
