{inputs, ...}: {
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
          # "copilot.lua"
          # "blink.cmp"
          # "colorful-winsep"
          # "nvim-treesitter"
        ];
      };
    };
  };
}
