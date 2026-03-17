{
  programs.nixvim.plugins.colorful-winsep = {
    enable = true;
    settings = {
      excluded_ft = [
        "packer"
        "TelescopePrompt"
        "mason"
        "CompetiTest"
        "NvimTree"
      ];
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
