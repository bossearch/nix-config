{
  hosts,
  pkgs,
  ...
}: let
  shell = hosts.shell;
  pkgsShell =
    if shell == "fish"
    then pkgs.fish
    else if shell == "zsh"
    then pkgs.zsh
    else pkgs.bash;
in {
  programs.zsh.enable = shell == "zsh";
  programs.fish.enable = shell == "fish";
  programs.bash.completion.enable = true;
  users.defaultUserShell = pkgsShell;
  environment.interactiveShellInit = ''
    export GPG_TTY=$(tty)
  '';
}
