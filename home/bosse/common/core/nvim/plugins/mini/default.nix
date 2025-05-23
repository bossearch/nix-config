# TODO: add mini.snippets and compare it with luasnip
{
  programs.nixvim.plugins.mini = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["VimEnter"];
      };
    };
    mockDevIcons = true;
    modules = {
      ai = {};
      icons = {};
      jump2d = {};
      surround = {};
      jump = import ./jump.nix;
      pairs = import ./pairs.nix;
      sessions = import ./sessions.nix;
      splitjoin = import ./splitjoin.nix;
    };
  };
}
