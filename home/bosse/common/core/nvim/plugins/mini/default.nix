{
  programs.nixvim.plugins.mini = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["VimEnter"];
      };
    };
    mockDevIcons = true;
    luaConfig = import ./post.nix;
    modules = {
      extra = {};
      icons = {};
      surround = {};
      ai = import ./ai.nix;
      jump2d = import ./jump2d.nix;
      pairs = import ./pairs.nix;
      sessions = import ./sessions.nix;
      splitjoin = import ./splitjoin.nix;
    };
  };
}
