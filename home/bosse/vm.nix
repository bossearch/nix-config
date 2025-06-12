{
  imports = [
    ./common/core
    ./common/optional/dunst
    # ./common/optional/feh.nix
    ./common/optional/firefox
    ./common/optional/gowall.nix
    ./common/optional/hyprland
    # ./common/optional/kdeconnect.nix
    ./common/optional/kitty.nix
    # ./common/optional/minecraft.nix
    # ./common/optional/mpv
    ./common/optional/nautilus.nix
    # ./common/optional/nchat
    # ./common/optional/neomutt.nix
    # ./common/optional/newsboat.nix
    # ./common/optional/nyaa.nix
    # ./common/optional/obsidian.nix
    # ./common/optional/qmk
    ./common/optional/spotify.nix
    ./common/optional/theme
    # ./common/optional/vaults.nix
    # ./common/optional/vesktop
    ./common/optional/waybar
    # ./common/optional/zathura.nix
  ];

  monitors = [
    {
      name = "Virtual-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      primary = true;
    }
  ];

  spec = {
    hostName = "vm";
    userName = "bosse";
    theme = "tokyo-night-dark";
  };

  # Do not change these future me !
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
