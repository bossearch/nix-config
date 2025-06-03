{...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

    #firefox
    windowrule = float, class:(firefox),title:(Library)
    windowrule = size 800 450, class:(firefox),title:(Save Image)
    windowrule = focusonactivate on, InitialClass:(firefox),initialTitle:(Mozilla Firefox)
    windowrule = opaque, class:(firefox),title:^(.*YouTube.*)$
    windowrule = opaque, class:(firefox),title:^(.*IDLIX.*)$
    windowrule = opaque, class:(firefox),title:^(.*Twitch.*)$
    windowrule = size 1280 720, class:(firefox),title:(File Upload)

    #blueman
    windowrule = workspace 4, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)
    windowrule = float, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)
    windowrule = size 720 480, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)

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
    windowrule = size 1280 720, initialClass:^(org.pulseaudio.pavucontrol)$

    #mpv
    windowrule = workspace 3, initialClass:(mpv)
    windowrule = opaque, initialClass:(mpv)

    #alacritty
    windowrule = workspace 1, initialTitle:(Alacritty)

    #kitty
    windowrule = workspace 1, initialTitle:(kitty)

    #btop
    windowrule = float, class:(kitty),title:(btop)
    windowrule = size 1980 1080, class:(kitty),title:(btop)

    #nchat
    windowrule = workspace 6, class:(kitty),title:(nchat)

    #nautilus
    windowrule = workspace 3, initialClass:^org\.gnome\.Nautilus$,initialTitle:^Loading…$
    windowrule = float, InitialClass:(org.gnome.NautilusPreviewer),class:(org.gnome.NautilusPreviewer)
    windowrule = opaque, InitialClass:(org.gnome.NautilusPreviewer),class:(org.gnome.NautilusPreviewer)
    windowrule = size 1280 720, title:^(Rename .* Files)$

    #nmtui
    windowrule = workspace 4, class:(kitty),title:(nmtui)
    windowrule = float, class:(kitty),title:(nmtui)
    windowrule = size 900 800, class:(kitty),title:(nmtui)

    #fzf
    windowrule = float, class:(kitty),title:(mousefzf)
    windowrule = size 1280 720, class:(kitty),title:(mousefzf)
    windowrule = float, class:(kitty),title:(fzf)
    windowrule = size 640 360, class:(kitty),title:(fzf)

    #fastfetch
    windowrule = float, class:(kitty),title:(fastfetch)
    windowrule = size 920 520, class:(kitty),title:(fastfetch)

    #crkbd
    windowrule = float, class:(kitty),title:(crkbd)
    windowrule = size 1310 1080, class:(kitty),title:(crkbd)

    #transmission
    windowrule = size 800 450, class:(transmission-gtk),title:(Open a Torrent)
    windowrule = center, class:(transmission-gtk),title:(Open a Torrent)
    windowrule = workspace 4, class:(transmission-gtk),title:(Transmission)

    #uget
    #windowrule = float, class:(uget-gtk),title:(uGet)
    windowrule = workspace 4, class:(uget-gtk),title:(uGet)
    windowrule = workspace 1, class:(uget-gtk),title:(uGet - New Download)
    windowrule = float, class:(uget-gtk),title:(uGet - New Download)
    windowrule = center, class:(uget-gtk),title:(uGet - New Download)

    #cryptomator
    windowrule = float, initialTitle:(Cryptomator),title:(Cryptomator)
    windowrule = center, initialTitle:(Cryptomator),title:(Cryptomator)
    windowrule = float, initialTitle:(Preferences),title:(Preferences)
    windowrule = center, initialTitle:(Preferences),title:(Preferences)
    windowrule = size 650 440, initialTitle:(Preferences),title:(Preferences)
    windowrule = center, initialTitle:(Add Existing Vault),title:(Add Existing Vault)
    windowrule = center, jinitialTitle:(Add New Vault),title:(Add New Vault)
    windowrule = float, initialTitle:(Update Check),title:(Update Check)
    windowrule = size 500 150, initialTitle:(Update Check),title:(Update Check)

    #svp
    windowrule = nomaxsize, class:(SVPManager),title:(SVP - Control Panel)
    windowrule = center, class:(SVPManager),title:(SVP - Control Panel)
    windowrule = size 1280 720, class:(SVPManager),title:(SVP - Control Panel)
    windowrule = size 1280 720, class:(SVPManager),title:(Open)
    windowrule = center, class:(SVPManager),title:(Open)

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
    windowrule = size 2560 1387, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$
    windowrule = maximize, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$
    windowrule = opaque, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$

    #Vaults
    windowrule = workspace 3, InitialClass:(io.github.mpobaschnig.Vaults),class:(Vaults)
    windowrule = float, InitialClass:(io.github.mpobaschnig.Vaults),class:(Vaults)
    windowrule = size 720 480, InitialClass:(io.github.mpobaschnig.Vaults),class:(Vaults)

    #zenity
    windowrule = rounding 14,class:zenity
    windowrule = float,class:zenity

    #mainpicker
    windowrule = float, initialTitle:(MainPicker),title:(MainPicker)
    windowrule = size 480 360, initialTitle:(MainPicker),title:(MainPicker)

    #localsend
    windowrule = float, class:(localsend_app),title:(Open File)
    windowrule = size 1600 900, class:(localsend_app),title:(Open File)
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
