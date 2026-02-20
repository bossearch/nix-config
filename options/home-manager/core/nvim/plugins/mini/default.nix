{
  programs.nixvim.plugins.mini = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["VimEnter"];
      };
    };
    mockDevIcons = true;
    luaConfig = import ./lua.nix;
    modules = {
      extra = {};
      icons = {};
      surround = import ./surround.nix;
      ai = import ./ai.nix;
      base16 = import ./base16.nix;
      pairs = import ./pairs.nix;
      sessions = import ./sessions.nix;
      splitjoin = import ./splitjoin.nix;
    };
  };
}
