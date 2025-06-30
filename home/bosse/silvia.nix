{
  imports = [
    ../common/core
    ../common/optional/dunst
    ../common/optional/feh.nix
    ../common/optional/firefox
    ../common/optional/gowall.nix
    ../common/optional/hyprland
    ../common/optional/kdeconnect.nix
    ../common/optional/kitty.nix
    ../common/optional/minecraft.nix
    ../common/optional/mpv
    ../common/optional/nautilus.nix
    ../common/optional/nchat
    ../common/optional/neomutt.nix
    ../common/optional/newsboat.nix
    ../common/optional/nyaa.nix
    ../common/optional/obsidian.nix
    ../common/optional/qmk
    ../common/optional/spotify.nix
    ../common/optional/theme
    ../common/optional/vaults.nix
    ../common/optional/vesktop
    ../common/optional/waybar
    ../common/optional/zathura.nix
  ];

  monitors = [
    {
      name = "DP-3";
      width = 2560;
      height = 1440;
      refreshRate = 165;
      primary = true;
    }
  ];

  spec = {
    hostName = "silvia";
    userName = "bosse";
    theme = "tokyo-night-dark";
  };

  # Do not change these future me !
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
