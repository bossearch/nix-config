{
  config,
  outputs,
  ...
}: {
  imports =
    [
      ./colors.nix
      ./cli
      ./mime.nix
      ./git.nix
      ./hm.nix
      ./nix.nix
      ./nvim
      ./shell
      ./sops.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  home = {
    username = "${config.spec.userName}";
    homeDirectory = "/home/${config.spec.userName}";
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
