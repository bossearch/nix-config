{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    lazyLoad = {
      settings = {
        event = ["UIEnter"];
      };
    };
    settings = {
      signs = false;
    };
  };
}
