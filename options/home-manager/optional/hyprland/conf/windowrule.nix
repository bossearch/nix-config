{homes, ...}: let
  coding = 1;
  browser = 2;
  music = 3;
  social = 4;
  file_manager = 5;
  game_launcher = 6;
  games = 7;
  virt_manager = 8;
  editing = 9;
  utilities = 10;

  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  size = {
    "3/4" =
      if mymonitor
      then "{ 1920, 1080 }"
      else "{ 1440, 810 }";
    "1/2" =
      if mymonitor
      then "{ 1280, 720 }"
      else "{ 960, 540 }";
    "1/4" =
      if mymonitor
      then "{ 640, 360 }"
      else "{ 480, 270 }";
    "1/3-3:2" =
      if mymonitor
      then "{ 720, 480 }"
      else "{ 540, 360 }";
    "1/2-1:1" =
      if mymonitor
      then "{ 720, 720 }"
      else "{ 540, 540 }";
    "1/5" =
      if mymonitor
      then "{ 512, 288 }"
      else "{ 384, 216 }";
    portrait =
      if mymonitor
      then "{ 982, 1387 }"
      else "{ 728, 1027 }";
  };
in {
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.windowrule" = {
      autoLoad = true;
      content = ''
        --------------------
        ---- WINDOWRULE ----
        --------------------

        local rules_config = {
            alacritty = {
                {
                    name = "normal",
                    match = {
                        class = "Alacritty",
                    },
                    workspace = ${toString coding},
                },
                {
                    name = "scratchpad",
                    match = {
                        class = "Alacritty",
                        title = "scratchpad",
                    },
                    workspace = "special:scratchpad",
                },
            },
            blueman = {
                match = {
                    class = ".blueman-manager-wrapped",
                    title = "Bluetooth Devices",
                },
                float = true,
                center = 1,
                size = ${size."1/3-3:2"},
            },
            bottles = {
                match = {
                    class = "com.usebottles.bottles",
                },
                workspace = ${toString game_launcher},
                opaque = true,
            },
            btop = {
                match = {
                    class = "footclient",
                    title = "btop",
                },
                float = true,
                center = 1,
                size = ${size."3/4"},
            },
            crkbd = {
                match = {
                    class = "footclient",
                    title = "crkbd",
                },
                float = true,
                center = 1,
                size = "1310 1080",
            },
            dn = {
                {
                    name = "launcher",
                    match = {
                        title = "DNOrigins Launcher",
                    },
                    workspace = ${toString games},
                    float = true,
                    center = 1,
                    no_initial_focus = true,
                },
                {
                    name = "game",
                    match = {
                        title = "DNOrigins",
                    },
                    workspace = ${toString games},
                    float = true,
                    center = 1,
                    immediate = true,
                    no_initial_focus = true,
                },
            },
            fastfetch = {
                match = {
                    class = "footclient",
                    title = "fastfetch",
                },
                float = true,
                center = 1,
                size = "520 600",
            },
            feh = {
                match = {
                    class = "feh",
                },
                float = true,
                center = 1,
            },
            firefox = {
                {
                    name = "workspace",
                    match = {
                        class = "firefox",
                    },
                    workspace = ${toString browser},
                },
                {
                    name = "library",
                    match = {
                        class = "firefox",
                        title = "Library",
                    },
                    float = true,
                    center = 1,
                },
                {
                    name = "dialogs",
                    match = {
                        class = "firefox",
                        title = "Save Image|File Upload",
                    },
                    size = ${size."1/2"},
                },
                {
                    name = "activate",
                    match = {
                        initial_class = "firefox",
                        initial_title = "Mozilla Firefox",
                    },
                    focus_on_activate = true,
                },
                {
                    name = "media",
                    match = {
                        class = "firefox",
                        title = ".*(YouTube|IDLIX|Twitch).*",
                    },
                    opaque = true,
                },
                {
                    name = "privacy",
                    match = {
                        class = "firefox",
                        title = ".*(Gmail|WhatsApp).*",
                    },
                    no_screen_share = true,
                },
            },
            fzf = {
                {
                    name = "smallfzf",
                    match = {
                        class = "footclient",
                        title = "smallfzf",
                    },
                    float = true,
                    center = 1,
                    size = ${size."1/4"},
                },
                {
                    name = "bigfzf",
                    match = {
                        class = "footclient",
                        title = "bigfzf",
                    },
                    float = true,
                    center = 1,
                    size = ${size."1/2"},
                },
            },
            gimp = {
                match = {
                    class = "gimp",
                },
                workspace = ${toString editing},
            },
            kdeconnect = {
                match = {
                    class = "org.kde.kdeconnect.*",
                },
                workspace = ${toString utilities},
                no_screen_share = true,
            },
            kdenlive = {
                match = {
                    class = "org.kde.kdenlive",
                },
                workspace = ${toString editing},
            },
            kitty = {
                {
                    name = "normal",
                    match = {
                        class = "kitty",
                    },
                    workspace = ${toString coding},
                },
                {
                    name = "scratchpad",
                    match = {
                        class = "kitty",
                        title = "scratchpad",
                    },
                    workspace = "special:scratchpad",
                },
            },
            localsend = {
                match = {
                    class = "localsend_app",
                    title = "Open File",
                },
                float = true,
                center = 1,
                size = ${size."1/2"},
            },
            lutris = {
                {
                    match = {
                        class = "net.lutris.Lutris",
                    },
                    workspace = ${toString game_launcher},
                    opaque = true,
                },
                {
                    name = "file-pickers",
                    match = {
                        class = "net.lutris.Lutris",
                        title = "(Please|Select|Configure).*",
                    },
                    float = true,
                    center = 1,
                    size = ${size."1/2"},
                },
            },
            mainpicker = {
                match = {
                    initial_title = "MainPicker",
                    title = "MainPicker",
                },
                float = true,
                center = 1,
                size = ${size."1/4"},
            },
            magicchess = {
                {
                    name = "workspace",
                    match = {
                        class = "steam_app_default",
                        title = ".*|Magic Chess: Go Go|MagicChessGoGo",
                    },
                    workspace = ${toString games},
                },
                {
                    name = "props",
                    match = {
                        class = "steam_app_default",
                        title = "Magic Chess: Go Go|MagicChessGoGo",
                    },
                    pseudo = true,
                    immediate = true,
                },
            },
            mpv = {
                match = {
                    class = "mpv",
                },
                opaque = true,
            },
            nautilus = {
                {
                    match = {
                        class = "org.gnome.Nautilus",
                    },
                    workspace = ${toString file_manager},
                },
                {
                    name = "previewer",
                    match = {
                        class = "org.gnome.NautilusPreviewer",
                    },
                    float = true,
                    center = 1,
                    opaque = true,
                    size = ${size."1/2"},
                },
            },
            nchat = {
                match = {
                    class = "footclient",
                    title = "nchat",
                },
                workspace = ${toString social},
                no_screen_share = true,
            },
            nmtui = {
                match = {
                    class = "footclient",
                    title = "nmtui",
                },
                float = true,
                center = 1,
                size = ${size."1/2-1:1"},
            },
            obs = {
                match = {
                    class = "obs",
                },
                workspace = ${toString utilities},
                opaque = true,
            },
            obsidian = {
                match = {
                    class = "obsidian",
                },
                workspace = ${toString coding},
            },
            pavucontrol = {
                match = {
                    class = "org.pulseaudio.pavucontrol",
                },
                float = true,
                center = 1,
                size = ${size."1/2"},
            },
            pcsx2 = {
                match = {
                    title = "PCSX2.*",
                },
                workspace = ${toString games},
                fullscreen = true,
                immediate = true,
            },
            prismlauncher = {
                {
                    name = "workspace",
                    match = {
                        class = "org.prismlauncher.PrismLauncher",
                    },
                    workspace = ${toString game_launcher},
                },
                {
                    name = "dialogs",
                    match = {
                        class = "org.prismlauncher.PrismLauncher",
                        title = "(New|Select|Download).*",
                    },
                    center = 1,
                    size = ${size."1/2"},
                },
                {
                    name = "wait-dialog",
                    match = {
                        class = "org.prismlauncher.PrismLauncher",
                        title = "Please wait.*",
                    },
                    center = 1,
                    size = ${size."1/5"},
                },
                {
                    name = "minecraft",
                    match = { title = "Minecraft.*" },
                    workspace = ${toString games},
                    pseudo = true,
                    immediate = true,
                },
            },
            retroarch = {
                match = {
                    class = "com.libretro.RetroArch",
                },
                workspace = ${toString games},
                fullscreen = true,
                immediate = true,
            },
            spotify = {
                match = {
                    class = "Spotify",
                },
                workspace = ${toString music},
            },
            steam = {
                {
                    name = "class-workspace",
                    match = {
                        class = "steam",
                    },
                    workspace = ${toString game_launcher},
                },
                {
                    name = "title-workspace",
                    match = {
                        title = "steam",
                    },
                    workspace = ${toString game_launcher},
                },
                {
                    name = "dota2",
                    match = {
                        class = "dota2",
                    },
                    workspace = ${toString games},
                    pseudo = true,
                    immediate = true,
                },
            },
            tor_browser = {
                match = {
                    class = "Tor Browser",
                },
                workspace = ${toString browser},
                no_screen_share = true,
            },
            transmission = {
                {
                    name = "workspace",
                    match = {
                        class = "transmission-gtk",
                    },
                    workspace = ${toString utilities},
                },
                {
                    name = "open-torrent",
                    match = {
                        class = "transmission-gtk",
                        title = "Open a Torrent",
                    },
                    float = true,
                    center = 1,
                    size = ${size."1/2"},
                },
            },
            veracrypt = {
                match = {
                    class = "veracrypt",
                },
                workspace = ${toString utilities},
                no_screen_share = true,
            },
            virt_manager = {
                {
                    name = "workspace",
                    match = {
                        class = ".virt-manager-wrapped",
                    },
                    workspace = ${toString virt_manager},
                },
                {
                    name = "kvm",
                    match = {
                        class = ".virt-manager-wrapped",
                        title = ".*QEMU/KVM",
                    },
                    workspace = ${toString virt_manager},
                    float = true,
                    center = 1,
                    size = "1920 1150",
                    opaque = true,
                },
            },
            vesktop = {
                {
                    name = "workspace",
                    match = {
                        class = "vesktop",
                    },
                    workspace = ${toString social},
                    no_screen_share = true,
                },
                {
                    name = "popout",
                    match = {
                        initial_class = "vesktop",
                        initial_title = "Discord Popout",
                    },
                    float = true,
                    center = 1,
                    size = ${size."3/4"},
                },
            },
            waydroid = {
                match = {
                    class = "Waydroid",
                },
                workspace = ${toString games},
                pseudo = true,
                immediate = true,
            },
            zathura = {
                match = {
                    class = "org.pwmt.zathura",
                },
                float = true,
                center = 1,
                size = ${size.portrait},
            },
            zenity = {
                match = {
                    class = "zenity",
                },
                float = true,
                center = 1,
                rounding = 18,
            },
            misc = {
                {
                    name = "suppress-maximize",
                    match = {
                        class = ".*",
                    },
                    suppress_event = "maximize",
                },
                {
                    name = "xdg-desktop-portal-share",
                    match = {
                        title = "Select what to share",
                    },
                    float = true,
                    center = 1,
                    size = ${size."1/4"},
                },
                {
                    name = "fix-xwayland-drags",
                    match = {
                        class = "^$",
                        title = "^$",
                        xwayland = true,
                        float = true,
                        fullscreen = false,
                        pin = false,
                    },
                    no_focus = true,
                },
            },
        }

        for app, rules in pairs(rules_config) do
            local rules_list = rules.match and { rules } or rules

            for _, rule in ipairs(rules_list) do
                rule.name = rule.name and (app .. "-" .. rule.name) or app
                hl.window_rule(rule)
            end
        end
      '';
    };
  };
}
