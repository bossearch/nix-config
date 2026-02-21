{
  inputs,
  mylib,
  ...
}: {
  imports =
    [
      inputs.nixvim.homeModules.nixvim
    ]
    ++ (mylib.autoimport ./.);

  programs.nixvim = {
    enable = true;
    performance = {
      byteCompileLua = {
        enable = true;
        configs = true;
        initLua = true;
        luaLib = true;
        nvimRuntime = true;
        plugins = true;
      };
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "friendly-snippets" # needed for blink to access friendly-snippets
          "outline.nvim"
          "fyler.nvim"
          "avante.nvim"
        ];
      };
    };
  };
}
