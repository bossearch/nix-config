{
  config,
  inputs,
  homes,
  hosts,
  mylib,
  pkgs,
  ...
}: let
  mylib' =
    mylib
    // {
      autoimport = path:
        map (p: args:
          import p (args
            // {
              config = config;
              pkgs = pkgs;
              mylib = mylib';
              hosts = hosts;
            })) (mylib.autoimport path);
    };
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  programs.nixvim = {
    enable = homes.neovim == "nix";
    imports = mylib'.autoimport ./.;
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
          "nvim-treesitter"
        ];
      };
    };
    withNodeJs = false;
    withPerl = false;
    withPython3 = false;
    withRuby = false;
    vimdiffAlias = true;
  };
}
