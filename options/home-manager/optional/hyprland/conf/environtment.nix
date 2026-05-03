{
  wayland.windowManager.hyprland.extraConfig = ''
    ####################
    ### ENVIRONTMENT ###
    ####################

    # See https://wiki.hypr.land/Configuring/Environment-variables/

    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_DESKTOP,Hyprland
    env = XDG_SESSION_TYPE,wayland

    env = GDK_BACKEND,wayland
    env = QT_QPA_PLATFORM,wayland;xcb
    env = SDL_VIDEODRIVER,wayland

    env = MOZ_ENABLE_WAYLAND,1
    env = WLR_NO_HARDWARE_CURSORS,1
    env = NIXOS_OZONE_WL,1

    # fix black border from context menu on nautilus
    # env = GSK_RENDERER,gl
  '';
}
