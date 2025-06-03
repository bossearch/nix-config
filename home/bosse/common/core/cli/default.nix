{pkgs, ...}: {
  imports = [
    ./bat
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
    bc
    curl
    eza
    fd
    ffmpeg
    imagemagick
    jq
    killall
    mediainfo
    moreutils
    ouch
    poppler
    ripgrep
    toipe
    unzip
    wget
  ];
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };
}
