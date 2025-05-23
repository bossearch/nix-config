{...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    ###########################
    ### DECORATION AND BLUR ###
    ###########################

    # https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration {
        rounding = 8
        # Change transparency of focused and unfocused windows
        active_opacity = 0.9
        inactive_opacity = 0.85

        blur {
            enabled = true
            size= 6 # minimum 1
            passes= 3 # minimum 1, more passes = more resource intensive.
            new_optimizations = true

            # Your blur "amount" is size * passes, but high size (over around 5-ish)
            # will produce artifacts.
            # if you want heavy blur, you need to up the passes.
            # the more passes, the more you can up the size without noticing artifacts.
        }
    }

    layerrule = blur, waybar # Add blur to waybar
    layerrule = ignorealpha 1, waybar # Remove weird excess layer
  '';
}
