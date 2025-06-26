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
        configs = true;
        initLua = false;
        luaLib = true;
        nvimRuntime = true;
        plugins = true;
      };
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "friendly-snippets" # needed for blink to access friendly-snippets
          "colorful-winsep"
          "img-clip.nvim"
          "outline.nvim"
        ];
      };
    };
  };
}
