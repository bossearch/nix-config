{...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

    #firefox
    windowrulev2 = float, class:(firefox),title:(Library)
    windowrulev2 = size 800 450, class:(firefox),title:(Save Image)
    windowrulev2 = focusonactivate on, InitialClass:(firefox),initialTitle:(Mozilla Firefox)
    windowrulev2 = opaque, class:(firefox),title:^(.*YouTube.*)$
    windowrulev2 = opaque, class:(firefox),title:^(.*IDLIX.*)$
    windowrulev2 = opaque, class:(firefox),title:^(.*Twitch.*)$
    windowrulev2 = size 1280 720, class:(firefox),title:(File Upload)

    #git-credential-manager
    windowrule = workspace 1, git-credential-manager

    #fdm
    windowrule = workspace 4, fdm
    windowrule = float, ^(fdm)$

    #blueman
    windowrulev2 = workspace 4, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)
    windowrulev2 = float, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)
    windowrulev2 = size 720 480, class:(.blueman-manager-wrapped),title:(Bluetooth Devices)

    #obsidian
    windowrule = workspace 5, obsidian

    #vesktop
    windowrulev2 = workspace 6, initialClass:(vesktop),initialTitle:(Discord)

    #spotify
    windowrulev2 = workspace 6, class:(spotify),title:(Spotify Premium)
    windowrulev2 = workspace 6, class:(spotify),title:(Spotify Free)

    #pavucontrol
    windowrule = workspace 4, org.pulseaudio.pavucontrol
    windowrule = float, ^(org.pulseaudio.pavucontrol)$
    windowrule = size 1280 720, ^(org.pulseaudio.pavucontrol)$

    #mpv
    windowrule = workspace 3, mpv
    windowrule = opaque, mpv

    #vlc
    windowrule = opaque, vlc

    #alacritty
    windowrulev2 = workspace 1, initialTitle:(Alacritty)

    #kitty
    windowrulev2 = workspace 1, initialTitle:(kitty)

    #btop
    windowrulev2 = float, class:(kitty),title:(btop)
    windowrulev2 = size 1980 1080, class:(kitty),title:(btop)

    #nchat
    windowrulev2 = workspace 6, class:(kitty),title:(nchat)

    #nautilus
    windowrulev2 = workspace 3, initialClass:^org\.gnome\.Nautilus$,initialTitle:^Loading…$
    windowrulev2 = float, InitialClass:(org.gnome.NautilusPreviewer),class:(org.gnome.NautilusPreviewer)
    windowrulev2 = opaque, InitialClass:(org.gnome.NautilusPreviewer),class:(org.gnome.NautilusPreviewer)
    windowrule = size 1280 720, title:^(Rename .* Files)$

    #nmtui
    windowrulev2 = workspace 4, class:(kitty),title:(nmtui)
    windowrulev2 = float, class:(kitty),title:(nmtui)
    windowrulev2 = size 900 800, class:(kitty),title:(nmtui)

    #fzf
    windowrulev2 = float, class:(kitty),title:(mousefzf)
    windowrulev2 = size 1280 720, class:(kitty),title:(mousefzf)
    windowrulev2 = float, class:(kitty),title:(fzf)
    windowrulev2 = size 640 360, class:(kitty),title:(fzf)

    #fastfetch
    windowrulev2 = float, class:(kitty),title:(fastfetch)
    windowrulev2 = size 920 520, class:(kitty),title:(fastfetch)

    #crkbd
    windowrulev2 = float, class:(kitty),title:(crkbd)
    windowrulev2 = size 1310 1080, class:(kitty),title:(crkbd)

    #transmission
    windowrulev2 = size 800 450, class:(transmission-gtk),title:(Open a Torrent)
    windowrulev2 = center, class:(transmission-gtk),title:(Open a Torrent)
    windowrulev2 = workspace 4, class:(transmission-gtk),title:(Transmission)

    #uget
    #windowrulev2 = float, class:(uget-gtk),title:(uGet)
    windowrulev2 = workspace 4, class:(uget-gtk),title:(uGet)
    windowrulev2 = workspace 1, class:(uget-gtk),title:(uGet - New Download)
    windowrulev2 = float, class:(uget-gtk),title:(uGet - New Download)
    windowrulev2 = center, class:(uget-gtk),title:(uGet - New Download)

    #cryptomator
    windowrulev2 = float, initialTitle:(Cryptomator),title:(Cryptomator)
    windowrulev2 = center, initialTitle:(Cryptomator),title:(Cryptomator)
    windowrulev2 = float, initialTitle:(Preferences),title:(Preferences)
    windowrulev2 = center, initialTitle:(Preferences),title:(Preferences)
    windowrulev2 = size 650 440, initialTitle:(Preferences),title:(Preferences)
    windowrulev2 = center, initialTitle:(Add Existing Vault),title:(Add Existing Vault)
    windowrulev2 = center, jinitialTitle:(Add New Vault),title:(Add New Vault)
    windowrulev2 = float, initialTitle:(Update Check),title:(Update Check)
    windowrulev2 = size 500 150, initialTitle:(Update Check),title:(Update Check)

    #svp
    windowrulev2 = nomaxsize, class:(SVPManager),title:(SVP - Control Panel)
    windowrulev2 = center, class:(SVPManager),title:(SVP - Control Panel)
    windowrulev2 = size 1280 720, class:(SVPManager),title:(SVP - Control Panel)
    windowrulev2 = size 1280 720, class:(SVPManager),title:(Open)
    windowrulev2 = center, class:(SVPManager),title:(Open)

    #steam
    windowrulev2 = workspace special:gamespace, class:(steam)
    windowrulev2 = workspace special:gamespace, class:(dota2)
    windowrulev2 = float, class:(dota2),title:(Dota 2)

    #prismlauncher
    windowrulev2 = workspace special:gamespace, class:(org.prismlauncher.PrismLauncher)
    windowrulev2 = workspace special:gamespace, class:^(Minecraft\* )$, title:^(Minecraft\* )$
    #waydroid
    windowrulev2 = workspace special:gamespace, class:(Waydroid), title:(Waydroid)

    #virt-manager
    windowrulev2 = workspace special:gamespace, class:(.virt-manager-wrapped), title:(Virtual Machine Manager)
    windowrulev2 = float, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$
    windowrulev2 = size 2560 1387, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$
    windowrulev2 = maximize, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$
    windowrulev2 = opaque, class:(.virt-manager-wrapped), title:^(.*QEMU/KVM)$

    #Vaults
    windowrulev2 = workspace 3, InitialClass:(io.github.mpobaschnig.Vaults),class:(Vaults)
    windowrulev2 = float, InitialClass:(io.github.mpobaschnig.Vaults),class:(Vaults)
    windowrulev2 = size 720 480, InitialClass:(io.github.mpobaschnig.Vaults),class:(Vaults)

    #thunar
    windowrule = float, title:^(File Operation Progress)$

    #zenity
    windowrulev2 = rounding 14,class:zenity
    windowrulev2 = float,class:zenity

    #mainpicker
    windowrulev2 = float, initialTitle:(MainPicker),title:(MainPicker)
    windowrulev2 = size 480 360, initialTitle:(MainPicker),title:(MainPicker)

    #localsend
    windowrulev2 = float, class:(localsend_app),title:(Open File)
    windowrulev2 = size 1600 900, class:(localsend_app),title:(Open File)
    windowrulev2 = center, class:(localsend_app),title:(Open File)

    #misc
    windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.

    # Workspaces
    workspace = special:scratchpad, gapsout:200, on-created-empty: kitty -T scratchpad
    workspace = special:gamespace, gapsout:8, gapsin:4, on-created-empty: ~/.config/hypr/scripts/zenity-run.sh
    workspace = special:anonymous, on-created-empty: nix-shell -p tor-browser --run tor-browser
    workspace = 1, on-created-empty: kitty sh -c '~/.config/hypr/scripts/assets/tty.sh; exec zsh'
    workspace = 2, on-created-empty: firefox
  '';
}
