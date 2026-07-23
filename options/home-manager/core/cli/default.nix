{
  hosts,
  mylib,
  pkgs,
  ...
}: let
  shell = hosts.shell;
in {
  imports = mylib.autoimport ./.;

  home.packages = with pkgs; [
    (pkgs.ouch.override {
      enableUnfree = true;
    })
    age
    bc
    chafa
    curl
    eza
    fd
    ffmpeg
    file
    hyperfine
    imagemagick
    jq
    killall
    mediainfo
    poppler
    ripgrep
    seniorpw
    ssh-to-age
    unzip
    wget
  ];
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
    enableBashIntegration = true;
    enableFishIntegration = shell == "fish";
    enableZshIntegration = shell == "zsh";
  };
}
