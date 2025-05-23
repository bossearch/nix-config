{...}: {
  imports = [
    ./common/core
    ./common/optional/dunst
    ./common/optional/firefox
    ./common/optional/gowall.nix
    ./common/optional/hyprland
    ./common/optional/kdeconnect.nix
    ./common/optional/kitty.nix
    ./common/optional/minecraft.nix
    ./common/optional/mpv
    ./common/optional/nautilus.nix
    ./common/optional/nchat
    ./common/optional/neomutt.nix
    ./common/optional/newsboat.nix
    ./common/optional/nyaa.nix
    ./common/optional/obsidian.nix
    ./common/optional/qmk.nix
    ./common/optional/spotify.nix
    ./common/optional/theme
    ./common/optional/vaults.nix
    ./common/optional/vesktop
    ./common/optional/waybar
  ];

  monitors = [
    {
      name = "DP-3";
      width = 1920;
      height = 1080;
      refreshRate = 165;
      primary = true;
    }
  ];

  spec = {
    hostName = "pc";
    userName = "bosse";
  };

  # Do not change these future me !
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
