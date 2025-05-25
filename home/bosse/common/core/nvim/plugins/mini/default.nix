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
      surround = {};
      jump = import ./jump.nix;
      jump2d = import ./jump2d.nix;
      pairs = import ./pairs.nix;
      sessions = import ./sessions.nix;
      splitjoin = import ./splitjoin.nix;
    };
  };
}
