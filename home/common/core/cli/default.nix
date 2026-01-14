{pkgs, ...}: {
  imports = [
    ./btop
    ./buku
    ./fastfetch
    ./fzf
    ./lazygit
    ./tealdeer
    ./tmux
    # ./uair
    ./yazi
  ];
  home.packages = with pkgs; [
    (pkgs.ouch.override {
      enableUnfree = true;
    })
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
  };
}
