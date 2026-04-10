{homes, ...}: let
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  size = {
    "3/4" =
      if mymonitor
      then "1920 1080"
      else "1440 810";
    "1/2" =
      if mymonitor
      then "1280 720"
      else "960 540";
    "1/4" =
      if mymonitor
      then "540 360"
      else "480 270";
    "1/3-3:2" =
      if mymonitor
      then "720 480"
      else "540 360";
    "1/2-1:1" =
      if mymonitor
      then "720 720"
      else "540 540";
    "1/5" =
      if mymonitor
      then "480 288"
      else "384 216";
    full =
      if mymonitor
      then "2540 1387"
      else "1900 1027";
    crkbd =
      if mymonitor
      then "1310 1080"
      else "1310 920";
    portrait =
      if mymonitor
      then "982 1387"
      else "728 1027";
    gapsout =
      if mymonitor
      then "200"
      else "150";
    about =
      if mymonitor
      then "920 520"
      else "778 440";
  };
in {
  wayland.windowManager.hyprland.extraConfig = ''
    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

    #alacritty
    windowrule = workspace 1, match:initial_title (Alacritty)

    #blueman
    # windowrule = workspace 4, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)
    windowrule = float on, center 1, size ${size."1/3-3:2"}, match:class (.blueman-manager-wrapped), match:title (Bluetooth Devices)

    #bottles
    windowrule = workspace special:gamespace, opaque on, match:class (com.usebottles.bottles)

    #btop
    windowrule = float on, center 1, size ${size."3/4"}, match:class (footclient), match:title (btop)

    #crkbd
    windowrule = float on, center 1, size 1310 1080, match:class (footclient), match:title (crkbd)

    #dn
    windowrule = workspace special:gamespace, center 1, opaque on, match:title (DNOrigins.*)

    #fastfetch
    windowrule = float on, center 1, size ${size.about}, match:class (footclient), match:title (fastfetch)

    #feh
    windowrule = float on, center 1, match:class (feh)

    #firefox
    windowrule = float on, center 1, match:class (firefox), match:title (Library)
    windowrule = size ${size."1/2"}, match:class (firefox), match:title (Save Image)
    windowrule = focus_on_activate on, match:initial_class (firefox), match:initial_title (Mozilla Firefox)
    windowrule = opaque on, match:class (firefox), match:title (.*YouTube.*)
    windowrule = opaque on, match:class (firefox), match:title (.*IDLIX.*)
    windowrule = opaque on, match:class (firefox), match:title (.*Twitch.*)
    windowrule = size ${size."1/2"}, match:class (firefox), match:title (File Upload)

    #foot
    windowrule = workspace 1, match:initial_title (foot)

    #fzf
    windowrule = float on, center 1, size ${size."1/4"}, match:class (footclient), match:title (fzf)
    windowrule = float on, center 1, size ${size."1/2"}, match:class (footclient), match:title (mousefzf)

    #obsidian
    windowrule = workspace 5, match:initial_class (obsidian)

    #kitty
    windowrule = workspace 1, match:initial_title (kitty)

    #localsend
    windowrule = float on, center 1, size ${size."1/2"}, match:class (localsend_app), match:title (Open File)

    #lutris
    windowrule = workspace special:gamespace, opaque on, match:class (net.lutris.Lutris)
    windowrule = float on, center 1, size ${size."1/2"}, match:class (net.lutris.Lutris), match:title (Please choose a custom image|Select file|Select folder|Select new location for the game|Configure.*)

    #mainpicker
    windowrule = float on, center 1, size ${size."1/4"}, match:initial_title (MainPicker), match:title (MainPicker)

    #magicchess
    windowrule = workspace special:gamespace, match:class (steam_app_default), match:title (.*|Magic Chess: Go Go|MagicChessGoGo)
    windowrule = center 1, opaque on, match:class (steam_app_default), match:title (Magic Chess: Go Go|MagicChessGoGo)

    #mpv
    windowrule = workspace 3, opaque on, match:initial_class (mpv)

    #nautilus
    windowrule = workspace 3, match:initial_class (org.gnome.Nautilus), match:initial_title (Loading…)
    windowrule = float on, center 1, opaque on, match:initial_class (org.gnome.NautilusPreviewer), match:class (org.gnome.NautilusPreviewer)
    windowrule = size ${size."1/2"}, match:title (Rename.*)

    #nchat
    windowrule = workspace 6, match:class (kitty), match:title (nchat)

    #nmtui
    # windowrule = workspace 4, class:(kitty),title:(nmtui)
    windowrule = float on, center 1, size ${size."1/2-1:1"}, match:class (footclient), match:title (nmtui)

    #pavucontrol
    # windowrule = workspace 4, initialClass:(org.pulseaudio.pavucontrol)
    windowrule = float on, center 1, size ${size."1/2"}, match:initial_class (org.pulseaudio.pavucontrol)

    #prismlauncher
    windowrule = workspace special:gamespace, match:class (org.prismlauncher.PrismLauncher)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (New Instance.*)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (Select a Java version.*)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (Download mods.*)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (Download resource packs.*)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (Download shader packs.*)
    windowrule = center 1, size ${size."1/5"}, match:class (org.prismlauncher.PrismLauncher), match:title (Please wait.*)

    windowrule = workspace special:gamespace, size ${size."3/4"}, center 1, opaque on, match:title (Minecraft.*)

    #spotify
    windowrule = workspace 6, match:class (spotify), match:title (Spotify Premium)
    windowrule = workspace 6, match:class (spotify), match:title (Spotify Free)

    #steam
    windowrule = workspace special:gamespace, match:class (steam)
    windowrule = workspace special:gamespace, match:class (dota2)
    windowrule = float on, center 1, match:class (dota2), match:title (Dota 2)

    # tor browser
    windowrule = workspace 2, match:class (Tor Browser), match:title (Tor Browser)

    #transmission
    windowrule = workspace 4, match:class (transmission-gtk), match:title (Transmission)
    windowrule = float on, center 1, size ${size."1/2"}, match:class (transmission-gtk), match:title (Open a Torrent)

    #uget
    windowrule = workspace 2, float on, center 1, match:class (uget-gtk), match:title (uGet - New Download)
    windowrule = workspace 4, match:class (uget-gtk), match:title (uGet)

    #vaults
    windowrule = workspace 3, float on, center 1, size ${size."1/3-3:2"}, match:class (io.github.mpobaschnig.Vaults), match:title (Vaults)

    #virt-manager
    windowrule = workspace 5, match:class (.virt-manager-wrapped), match:title (Virtual Machine Manager)
    windowrule = workspace 5, float on, center 1, size ${size.full}, opaque on, match:class (.virt-manager-wrapped), match:title (.*QEMU/KVM)

    #vesktop
    windowrule = workspace 6, match:initial_class (vesktop), match:initial_title (vesktop)
    windowrule = workspace 6, match:initial_class (vesktop), match:initial_title (.*Discord.*)
    windowrule = float on, center 1, size ${size."3/4"}, match:initial_class (vesktop), match:initial_title (Discord Popout)

    #waydroid
    windowrule = workspace special:gamespace, match:class (Waydroid), match:title (Waydroid)

    #xdm
    windowrule = float on, center 1, match:class (Xdm-app), match:title (Xtreme Download Manager|Settings|New Download|Download Complete|.*%.*)
    windowrule = size ${size."1/3-3:2"}, match:class (Xdm-app), match:title (Xtreme Download Manager|Settings)
    windowrule = size ${size."1/4"}, match:class (Xdm-app), match:title (New Download|Download Complete|.*%.*)

    #xdg-desktop-portal-hyprland
    windowrule = float on, center 1, size ${size."1/4"}, match:title (Select what to share)

    #zathura
    windowrule = float on, center 1, size ${size.portrait}, match:class (org.pwmt.zathura)

    #zenity
    windowrule = float on, center 1, rounding 18, match:class (zenity)

    #misc
    windowrule = suppress_event maximize, match:class .* # You'll probably like this.

    # Workspaces
    workspace = special:scratchpad, gapsout:${size.gapsout}, on-created-empty: kitty -T scratchpad
    workspace = special:gamespace, on-created-empty: hyprctl dispatch togglespecialworkspace "gamespace"
    workspace = 1, on-created-empty: kitty sh -c '~/.config/hypr/scripts/assets/tty.sh; exec fish'
    workspace = 2, on-created-empty: firefox
  '';
}
