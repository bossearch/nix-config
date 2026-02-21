{hosts, ...}: {
  home = {
    username = "${hosts.username}";
    homeDirectory = "/home/${hosts.username}";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      MANPAGER = "nvim +Man!";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
