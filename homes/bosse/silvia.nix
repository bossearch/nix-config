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
        name = "DP-3";
        width = 2560;
        height = 1440;
        refreshRate = 165;
        primary = true;
      }
    ];
    firefox = {
      enable = true;
      allowlist = [
        "https://accounts.google.com"
        "https://bossearch.github.io"
        "https://chatgpt.com"
        "https://codeberg.org"
        "https://duckduckgo.com"
        "https://github.com"
        "https://gitlab.com"
        "https://mail.google.com"
        "https://proton.me"
        "https://reddit.com"
        "https://start.duckduckgo.com"
        "https://tokopedia.com"
        "https://twitch.tv"
        "https://youtube.com"
      ];
    };
    game = {
      lsfg = false;
      lutris = true;
      prismlauncher = true;
    };
    alacritty = false;
    copas = true;
    dunst = true;
    feh = true;
    gowall = true;
    kdeconnect = false;
    kitty = true;
    lanmouse = true;
    llm = true;
    mpv = true;
    nautilus = true;
    nchat = false;
    neomutt = false;
    newsboat = false;
    nyaa = true;
    obsidian = true;
    spicetify = true;
    vaults = true;
    vesktop = true;
    waybar = true;
    zathura = true;
  };

  # Do not change these future me !
  home.stateVersion = "24.11"; # Please read the comment before changing.
}
