{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      python313Packages.pylatexenc
    ];
    plugins.render-markdown = {
      enable = true;
      lazyLoad = {
        settings = {
          ft = "markdown";
        };
      };
      settings = {
        enabled = false;
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
