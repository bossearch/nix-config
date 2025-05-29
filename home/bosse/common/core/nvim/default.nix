{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./core
    ./lib
    ./plugins
  ];
  programs.nixvim = {
    enable = true;
    performance = {
      byteCompileLua = {
        enable = true;
        nvimRuntime = true;
        configs = true;
        plugins = true;
      };
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "copilot.lua"
          "blink.cmp"
          "nvim-treesitter"
          "colorful-winsep"
        ];
      };
    };
    extraPlugins = with pkgs; [
      vimPlugins.colorful-winsep
      vimPlugins.outline-nvim
      vimPlugins.img-clip-nvim
    ];
  };
}
