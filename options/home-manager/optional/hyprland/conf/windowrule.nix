{
  homes,
  hosts,
  ...
}: let
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
  terminal =
    if homes.terminal == "alacritty"
    then "alacritty -e sh -c '~/.config/hypr/scripts/assets/tty.sh; exec ${hosts.shell}'"
    else if homes.terminal == "kitty"
    then "kitty sh -c '~/.config/hypr/scripts/assets/tty.sh; exec ${hosts.shell}'"
    else "";
in {
  wayland.windowManager.hyprland.extraConfig = ''
    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # See https://wiki.hypr.land/Configuring/Window-Rules/ for more

    #alacritty
    windowrule = workspace ${toString coding}, match:class (Alacritty)

    #blueman
    windowrule = float on, center 1, size ${size."1/3-3:2"}, match:class (.blueman-manager-wrapped), match:title (Bluetooth Devices)

    #bottles
    windowrule = workspace ${toString game_launcher}, opaque on, match:class (com.usebottles.bottles)

    #btop
    windowrule = float on, center 1, size ${size."3/4"}, match:class (footclient), match:title (btop)

    #crkbd
    windowrule = float on, center 1, size 1310 1080, match:class (footclient), match:title (crkbd)

    #dn
    windowrule = workspace ${toString games}, float on, center 1, no_initial_focus on, match:title (DNOrigins Launcher)
    windowrule = workspace ${toString games}, float on, center 1, immediate on, no_initial_focus on, match:title (DNOrigins)

    #fastfetch
    windowrule = float on, center 1, size ${size.about}, match:class (footclient), match:title (fastfetch)

    #feh
    windowrule = float on, center 1, match:class (feh)

    #firefox
    windowrule = workspace ${toString browser}, match:class (firefox)
    windowrule = float on, center 1, match:class (firefox), match:title (Library)
    windowrule = size ${size."1/2"}, match:class (firefox), match:title (Save Image)
    windowrule = focus_on_activate on, match:initial_class (firefox), match:initial_title (Mozilla Firefox)
    windowrule = opaque on, match:class (firefox), match:title (.*YouTube.*)
    windowrule = opaque on, match:class (firefox), match:title (.*IDLIX.*)
    windowrule = opaque on, match:class (firefox), match:title (.*Twitch.*)
    windowrule = size ${size."1/2"}, match:class (firefox), match:title (File Upload)

    #foot
    windowrule = workspace ${toString coding}, match:class (foot)

    #fzf
    windowrule = float on, center 1, size ${size."1/4"}, match:class (footclient), match:title (fzf)
    windowrule = float on, center 1, size ${size."1/2"}, match:class (footclient), match:title (mousefzf)

    #kdeconnect
    windowrule = workspace ${toString utilities}, match:class (org.kde.kdeconnect.*)

    #kitty
    windowrule = workspace ${toString coding}, match:class (kitty)

    #localsend
    windowrule = float on, center 1, size ${size."1/2"}, match:class (localsend_app), match:title (Open File)

    #lutris
    windowrule = workspace ${toString game_launcher}, opaque on, match:class (net.lutris.Lutris)
    windowrule = float on, center 1, size ${size."1/2"}, match:class (net.lutris.Lutris), match:title (Please choose a custom image|Select file|Select folder|Select new location for the game|Configure.*)

    #mainpicker
    windowrule = float on, center 1, size ${size."1/4"}, match:initial_title (MainPicker), match:title (MainPicker)

    #magicchess
    windowrule = workspace ${toString games}, match:class (steam_app_default), match:title (.*|Magic Chess: Go Go|MagicChessGoGo)
    windowrule = pseudo on, immediate on, match:class (steam_app_default), match:title (Magic Chess: Go Go|MagicChessGoGo)

    #mpv
    windowrule = opaque on, match:class (mpv)

    #nautilus
    windowrule = workspace ${toString file_manager}, match:class (org.gnome.Nautilus)
    windowrule = float on, center 1, opaque on, size ${size."1/2"}, match:class (org.gnome.NautilusPreviewer)

    #nchat
    windowrule = workspace ${toString social}, match:class (footclient), match:title (nchat)

    #nmtui
    windowrule = float on, center 1, size ${size."1/2-1:1"}, match:class (footclient), match:title (nmtui)

    #obsidian
    windowrule = workspace ${toString coding}, match:class (obsidian)

    #pavucontrol
    windowrule = float on, center 1, size ${size."1/2"}, match:class (org.pulseaudio.pavucontrol)

    #prismlauncher
    windowrule = workspace ${toString game_launcher}, match:class (org.prismlauncher.PrismLauncher)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (New Instance.*)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (Select a Java version.*)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (Download mods.*)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (Download resource packs.*)
    windowrule = center 1, size ${size."1/2"}, match:class (org.prismlauncher.PrismLauncher), match:title (Download shader packs.*)
    windowrule = center 1, size ${size."1/5"}, match:class (org.prismlauncher.PrismLauncher), match:title (Please wait.*)
    windowrule = workspace ${toString games}, pseudo on, immediate on, match:title (Minecraft.*)
    #spotify
    windowrule = workspace ${toString music}, match:class (spotify)

    #steam
    windowrule = workspace ${toString game_launcher}, match:class (steam)
    windowrule = workspace ${toString game_launcher}, match:title (steam)
    windowrule = workspace ${toString games}, pseudo on, immediate on, match:class (dota2)

    # tor browser
    windowrule = workspace ${toString browser}, match:class (Tor Browser)

    #transmission
    windowrule = workspace ${toString utilities}, match:class (transmission-gtk)
    windowrule = float on, center 1, size ${size."1/2"}, match:class (transmission-gtk), match:title (Open a Torrent)

    #veracrypt
    windowrule = workspace ${toString utilities}, match:class (veracrypt)

    #virt-manager
    windowrule = workspace ${toString virt_manager}, match:class (.virt-manager-wrapped)
    windowrule = workspace ${toString virt_manager}, float on, center 1, size 1920 1150, opaque on, match:class (.virt-manager-wrapped), match:title (.*QEMU/KVM)

    #vesktop
    windowrule = workspace ${toString social}, match:class (vesktop)
    windowrule = float on, center 1, size ${size."3/4"}, match:initial_class (vesktop), match:initial_title (Discord Popout)

    #waydroid
    windowrule = workspace ${toString games}, pseudo on, immediate on, match:class (Waydroid)

    #zathura
    windowrule = float on, center 1, size ${size.portrait}, match:class (org.pwmt.zathura)

    #zenity
    windowrule = float on, center 1, rounding 18, match:class (zenity)

    #misc
    windowrule = suppress_event maximize, match:class .* # You'll probably like this.
    windowrule = float on, center 1, size ${size."1/4"}, match:title (Select what to share) # xdg-desktop-portal-hyprland

    # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
    # Workspaces
    workspace = special:scratchpad, gapsout:${size.gapsout}, on-created-empty: ${homes.terminal} -T scratchpad
    workspace = ${toString coding}, layout:monocle, on-created-empty: ${terminal}
    workspace = ${toString browser},layout:scrolling, on-created-empty: firefox
    workspace = ${toString game_launcher}, layout:scrolling
    workspace = ${toString games}, layout:monocle
  '';
}
