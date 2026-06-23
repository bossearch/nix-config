{mylib, ...}: {
  imports = [
    (mylib.at "options/home-manager")
  ];

  homes = {
    nerdfont = "CommitMono";
    cursor = "macOS";
    icon = "Papirus-Dark";
    qtstyle = "breeze";
    terminal = "alacritty";
    notify = "swaync";
    monitor = [
      {
        name = "DP-1";
        width = 2560;
        height = 1440;
        refreshRate = 165;
        primary = true;
        vrr = false;
      }
    ];
    firefox = {
      enable = true;
      verticaltab = {
        enable = false;
        position = "left";
      };
    };
    game = {
      lsfg = false;
      lutris = true;
      prismlauncher = true;
      retroarch = true;
    };
    copas = true;
    feh = true;
    gowall = true;
    kdeconnect = false;
    llm = true;
    mpv = true;
    nautilus = true;
    nchat = false;
    neomutt = false;
    newsboat = true;
    nyaa = true;
    obs = true;
    obsidian = true;
    spicetify = true;
    vaults = true;
    vesktop = true;
    waybar = true;
    zathura = true;
  };

  # Do not change these future me !
  home.stateVersion = "24.11";
}
