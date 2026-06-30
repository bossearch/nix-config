{
  inputs,
  mylib,
  pkgs,
  ...
}: {
  imports =
    [
      inputs.nixvim.homeModules.nixvim
    ]
    ++ (mylib.autoimport ./.);

  programs.nixvim = {
    enable = true;
    nixpkgs.pkgs = pkgs;
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
          "blink.cmp"
          "blink-cmp-words" # needed so blink-cmp-words can use wordnet & fzy
          "friendly-snippets" # needed for blink to access friendly-snippets
          "fyler.nvim"
          "nvim-treesitter"
          "outline.nvim"
        ];
      };
    };
  };
}
