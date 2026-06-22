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
        name = "Virtual-1";
        width = 1920;
        height = 1080;
        refreshRate = 60;
        primary = true;
        vrr = false;
      }
    ];
    firefox = {
      enable = true;
      verticaltab = {
        enable = true;
        position = "left";
      };
    };
    game = {
      lsfg = false;
      lutris = false;
      prismlauncher = false;
    };
    copas = false;
    feh = false;
    gowall = false;
    kdeconnect = false;
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
  home.stateVersion = "24.11";
}
