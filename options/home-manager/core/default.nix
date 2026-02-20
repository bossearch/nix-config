{
  hosts,
  lib,
  outputs,
  ...
}: {
  imports =
    lib.foldlAttrs
    (
      acc: name: type:
        acc
        ++ (
          if name == "default.nix"
          then []
          else if type == "regular" || type == "directory"
          then [./${name}]
          else []
        )
    )
    []
    (builtins.readDir ./.)
    ++ (builtins.attrValues outputs.homeManagerModules);

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
