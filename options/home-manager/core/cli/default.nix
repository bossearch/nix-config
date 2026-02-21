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
    moreutils
    poppler
    ripgrep
    seniorpw
    ssh-to-age
    taskwarrior3
    toipe
    unzip
    wget
  ];
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "ansi";
    };
  };
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
    enableBashIntegration = shell == "bash";
    enableFishIntegration = shell == "fish";
    enableZshIntegration = shell == "zsh";
  };
  programs.fzf = {
    enableBashIntegration = shell == "bash";
    enableFishIntegration = shell == "fish";
    enableZshIntegration = shell == "zsh";
  };
}
