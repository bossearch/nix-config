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
    monitor = [
      {
        name = "DP-1";
        width = 2560;
        height = 1440;
        refreshRate = 165;
        modeline = "modeline 679.10 2560 2568 2600 2640 1440 1545 1553 1559 +hsync -vsync";
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
      playstation = true;
      prismlauncher = true;
      retroarch = true;
    };
    ai = {
      opencode = true;
      ollama = false;
    };
    copas = true;
    feh = true;
    gimp = true;
    gowall = true;
    kdeconnect = false;
    kdenlive = true;
    mako = true;
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
