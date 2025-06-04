{config, ...}: let
  mymonitor = builtins.all (m: m.height == 1440) config.monitors;
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
    full =
      if mymonitor
      then "2540 1387"
      else "1900 1027";
    crkbd =
      if mymonitor
      then "1310 1080"
      else "1310 920";
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

    #firefox
    windowrule = float, class:(firefox),title:(Library)
    windowrule = size ${size."1/2"}, class:(firefox),title:(Save Image)
    windowrule = focusonactivate on, InitialClass:(firefox),initialTitle:(Mozilla Firefox)
    windowrule = opaque, class:(firefox),title:^(.*YouTube.*)$
    windowrule = opaque, class:(firefox),title:^(.*IDLIX.*)$
    windowrule = opaque, class:(firefox),title:^(.*Twitch.*)$
    windowrule = size ${size."1/2"}, class:(firefox),title:(File Upload)

    #blueman
    windowrule = workspace 4, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)
    windowrule = float, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)
    windowrule = size ${size."1/3-3:2"}, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)

    #obsidian
    windowrule = workspace 5, initialClass:(obsidian)

    #vesktop
    windowrule = workspace 6, initialClass:(vesktop),initialTitle:(Discord)

    #spotify
    windowrule = workspace 6, class:(spotify),title:(Spotify Premium)
    windowrule = workspace 6, class:(spotify),title:(Spotify Free)

    #pavucontrol
    windowrule = workspace 4, initialClass:(org.pulseaudio.pavucontrol)
    windowrule = float, initialClass:^(org.pulseaudio.pavucontrol)$
    windowrule = size ${size."1/2"}, initialClass:^(org.pulseaudio.pavucontrol)$

    #mpv
    windowrule = workspace 3, initialClass:(mpv)
    windowrule = opaque, initialClass:(mpv)

    #alacritty
    windowrule = workspace 1, initialTitle:(Alacritty)

    #kitty
    windowrule = workspace 1, initialTitle:(kitty)

    #btop
    windowrule = float, class:(kitty),title:(btop)
    windowrule = size ${size."3/4"}, class:(kitty),title:(btop)

    #nchat
    windowrule = workspace 6, class:(kitty),title:(nchat)

    #nautilus
    windowrule = workspace 3, initialClass:^org\.gnome\.Nautilus$,initialTitle:^Loading…$
    windowrule = float, InitialClass:(org.gnome.NautilusPreviewer),class:(org.gnome.NautilusPreviewer)
    windowrule = opaque, InitialClass:(org.gnome.NautilusPreviewer),class:(org.gnome.NautilusPreviewer)
    windowrule = size ${size."1/2"}, title:^(Rename .* Files)$

    #nmtui
    windowrule = workspace 4, class:(kitty),title:(nmtui)
    windowrule = float, class:(kitty),title:(nmtui)
    windowrule = size ${size."1/2-1:1"}, class:(kitty),title:(nmtui)

    #fzf
    windowrule = float, class:(kitty),title:(mousefzf)
    windowrule = size ${size."1/2"}, class:(kitty),title:(mousefzf)
    windowrule = float, class:(kitty),title:(fzf)
    windowrule = size ${size."1/4"}, class:(kitty),title:(fzf)

    #fastfetch
    windowrule = float, class:(kitty),title:(fastfetch)
    windowrule = size ${size.about}, class:(kitty),title:(fastfetch)

    #crkbd
    windowrule = float, class:(kitty),title:(crkbd)
    windowrule = size ${size.crkbd}, class:(kitty),title:(crkbd)

    #transmission
    windowrule = size ${size."1/2"}, class:(transmission-gtk),title:(Open a Torrent)
    windowrule = center, class:(transmission-gtk),title:(Open a Torrent)
    windowrule = workspace 4, class:(transmission-gtk),title:(Transmission)

    #uget
    #windowrule = float, class:(uget-gtk),title:(uGet)
    windowrule = workspace 4, class:(uget-gtk),title:(uGet)
    windowrule = workspace 1, class:(uget-gtk),title:(uGet - New Download)
    windowrule = float, class:(uget-gtk),title:(uGet - New Download)
    windowrule = center, class:(uget-gtk),title:(uGet - New Download)

    #steam
    windowrule = workspace special:gamespace, class:(steam)
    windowrule = workspace special:gamespace, class:(dota2)
    windowrule = float, class:(dota2),title:(Dota 2)

    #prismlauncher
    windowrule = workspace special:gamespace, class:(org.prismlauncher.PrismLauncher)
    windowrule = workspace special:gamespace, class:^(Minecraft\* )$, title:^(Minecraft\* )$
    #waydroid
    windowrule = workspace special:gamespace, class:(Waydroid), title:(Waydroid)

    #virt-manager
    windowrule = workspace special:gamespace, class:(.virt-manager-wrapped), title:(Virtual Machine Manager)
    windowrule = float, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$
    windowrule = size ${size.full}, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$
    windowrule = maximize, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$
    windowrule = opaque, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$

    #Vaults
    windowrule = workspace 3, InitialClass:(io.github.mpobaschnig.Vaults),class:(Vaults)
    windowrule = float, InitialClass:(io.github.mpobaschnig.Vaults),class:(Vaults)
    windowrule = size ${size."1/3-3:2"}, InitialClass:(io.github.mpobaschnig.Vaults),class:(Vaults)

    #zenity
    windowrule = rounding 14,class:zenity
    windowrule = float,class:zenity

    #mainpicker
    windowrule = float, initialTitle:(MainPicker),title:(MainPicker)
    windowrule = size ${size."1/4"}, initialTitle:(MainPicker),title:(MainPicker)

    #localsend
    windowrule = float, class:(localsend_app),title:(Open File)
    windowrule = size ${size."1/2"}, class:(localsend_app),title:(Open File)
    windowrule = center, class:(localsend_app),title:(Open File)

    #misc
    windowrule = suppressevent maximize, class:.* # You'll probably like this.

    # Workspaces
    workspace = special:scratchpad, gapsout:200, on-created-empty: kitty -T scratchpad
    workspace = special:gamespace, gapsout:8, gapsin:4, on-created-empty: ~/.config/hypr/scripts/zenity-run.sh
    workspace = special:anonymous, on-created-empty: nix-shell -p tor-browser --run tor-browser
    workspace = 1, on-created-empty: kitty sh -c '~/.config/hypr/scripts/assets/tty.sh; exec fish'
    workspace = 2, on-created-empty: firefox
  '';
}
