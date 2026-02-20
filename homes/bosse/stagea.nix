{
  imports = [
    ../../options/home-manager
  ];

  homes = {
    nerdfont = "CommitMono";
    cursor = "macOS";
    icon = "Papirus-Dark";
    monitor = [
      {
        name = "Virtual-1";
        width = 1920;
        height = 1080;
        refreshRate = 60;
        primary = true;
      }
    ];
    firefox = {
      enable = false;
      allowlist = [];
    };
    game = {
      lsfg = false;
      lutris = false;
      prismlauncher = false;
    };
    alacritty = false;
    copas = false;
    dunst = true;
    feh = false;
    gowall = false;
    kdeconnect = false;
    kitty = true;
    lanmouse = false;
    llm = false;
    mpv = false;
    nautilus = false;
    nchat = false;
    neomutt = false;
    newsboat = false;
    nyaa = false;
    obsidian = false;
    spicetify = false;
    vaults = false;
    vesktop = false;
    waybar = true;
    zathura = false;
  };

  # Do not change these future me !
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
