{
  config,
  lib,
  outputs,
  ...
}: {
  imports =
    [
      ./cli
      ./git.nix
      ./nixpkgs.nix
      ./nvim
      ./shell/zsh.nix
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
    activation.drunScan = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${config.home.homeDirectory}/.nix-config/scripts/drun-scan.sh
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
