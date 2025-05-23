{
  pkgs,
  ...
}: {
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
  home.packages = with pkgs;
    [
      bc
      curl
      eza
      fd
      ffmpeg
      # fzf
      imagemagick
      jq
      killall
      ouch
      poppler
      ripgrep
      toipe
      unzip
      wget
      moreutils
      mediainfo
    ];
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
}
