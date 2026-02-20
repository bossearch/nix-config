{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      python313Packages.pylatexenc
    ];
    plugins.render-markdown = {
      enable = true;
      settings = {
        enabled = true;
        file_types = ["markdown" "Avante"];
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
