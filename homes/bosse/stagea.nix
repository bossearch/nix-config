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
    neovim = "lua";
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
      pcsx2 = false;
      prismlauncher = false;
      retroarch = false;
    };
    ai = {
      opencode = true;
      ollama = false;
    };
    copas = false;
    feh = false;
    gimp = false;
    gowall = false;
    kdeconnect = false;
    kdenlive = false;
    mpv = false;
    nautilus = false;
    nchat = false;
    neomutt = false;
    newsboat = false;
    nyaa = false;
    obs = false;
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
