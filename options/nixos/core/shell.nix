{
  lib,
  pkgs,
  config,
  ...
}: let
  shell = config.spec.shell;
in {
  programs.zsh.enable = shell == "zsh";
  programs.fish.enable = shell == "fish";
  programs.bash.completion.enable = true;
  users.defaultUserShell = lib.mkForce (
    if shell == "fish"
    then pkgs.fish
    else if shell == "zsh"
    then pkgs.zsh
    else pkgs.bash
  );
  environment.interactiveShellInit = ''
    export GPG_TTY=$(tty)
  '';
}
