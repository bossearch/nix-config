{...}: {
  plugins.mini = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["VimEnter"];
      };
    };
    mockDevIcons = true;
    modules = {
      extra = {};
      icons = {};
      surround = import ./surround.nix;
      ai = import ./ai.nix;
      sessions = import ./sessions.nix;
      splitjoin = import ./splitjoin.nix;
    };
  };
}
