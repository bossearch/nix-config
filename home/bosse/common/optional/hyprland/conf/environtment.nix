{
  wayland.windowManager.hyprland.extraConfig = ''
    ####################
    ### ENVIRONTMENT ###
    ####################

    # See https://wiki.hyprland.org/Configuring/Environment-variables/

    env = XCURSOR_SIZE,24
    env = XCURSOR_THEME,Adwaita
    env = HYPRCURSOR_SIZE,24
    env = HYPRCURSOR_THEME,Adwaita

    env = QT_QPA_PLATFORM,wayland;xcb
    # env = QT_QPA_PLATFORMTHEME,qt6ct
    env = QT_STYLE_OVERRIDE=kvantum
    env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

    env = XDG_SESSION_TYPE,wayland
    env = SDL_VIDEODRIVER,wayland
    env = XDG_CURRENT_DESKTOP,Hyprland
    env = XDG_SESSION_DESKTOP,Hyprland

    env = GDK_BACKEND,wayland
    env = WLR_BACKEND,vulkan

    env = MOZ_ENABLE_WAYLAND,1
    env = WLR_NO_HARDWARE_CURSORS,1
    env = NIXOS_OZONE_WL,1

    # fix black border from context menu on nautilus
    env = GSK_RENDERER,gl
  '';
}
