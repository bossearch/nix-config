{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      python313Packages.pylatexenc
    ];
    plugins.render-markdown = {
      enable = true;
      lazyLoad = {
        settings = {
          cmd = ["RenderMarkdown"];
          keys = ["<leader>m"];
        };
      };
      settings = {
        enabled = false;
        file_types = ["markdown"];
        code = {
          sign = false;
        };
        heading = {
          sign = false;
          icons = ["󰎤 " "󰎧 " "󰎪 " "󰎭 " "󰎱 " "󰎳 "];
        };
      };
    };
  };
}
