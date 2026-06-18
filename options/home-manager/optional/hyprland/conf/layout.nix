{
  wayland.windowManager.hyprland.extraConfig = ''
    ##############
    ### LAYOUT ###
    ##############

    # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
    dwindle {
      preserve_split = true # You probably want this
    }

    # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
    master {
      mfact = 0.5
    }

    # See https://wiki.hypr.land/Configuring/Scrolling-Layout/
    scrolling {
      direction = right
    }
  '';
}
