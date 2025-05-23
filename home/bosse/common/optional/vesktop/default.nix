{
  pkgs,
  ...
}: {
  imports = [
    ./theme.nix
  ];
  home.packages = with pkgs; [
    vesktop
  ];
}
