{pkgs, ...}: {
  programs.zsh.enable = false;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
}
