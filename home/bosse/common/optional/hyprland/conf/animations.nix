{...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    ##################
    ### ANIMATIONS ###
    ##################

    # https://wiki.hyprland.org/Configuring/Variables/#animations
    animations {
        enabled = true

        bezier = linear, 0, 0, 1, 1
        bezier = curve, 0.27, 0.7, 0.03, 0.99
        bezier = md3_decel, 0.05, 0.7, 0.1, 1

        animation = windows, 1, 1, linear, slide
        animation = windowsOut, 1, 1, linear, slide
        animation = windowsIn, 1, 1, linear, slide
        animation = windowsMove, 1, 1, linear, slide
        animation = border, 1, 4, default
        animation = fade, 1, 4, default
        animation = fadeDim, 1, 4, default
        animation = workspaces, 1, 2, md3_decel, slide
        animation = specialWorkspace, 1, 2, md3_decel, slidevert
    }
  '';
}
