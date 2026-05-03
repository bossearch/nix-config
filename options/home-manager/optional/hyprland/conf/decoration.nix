{
  wayland.windowManager.hyprland.extraConfig = ''
    ###########################
    ### DECORATION AND BLUR ###
    ###########################

    # https://wiki.hypr.land/Configuring/Variables/#decoration
    decoration {
        rounding = 8
        # Change transparency of focused and unfocused windows
        active_opacity = 0.9
        inactive_opacity = 0.85

        blur {
            enabled = true
            size= 6 # minimum 1
            passes= 4 # minimum 1, more passes = more resource intensive.
            new_optimizations = true

            # Your blur "amount" is size * passes, but high size (over around 5-ish)
            # will produce artifacts.
            # if you want heavy blur, you need to up the passes.
            # the more passes, the more you can up the size without noticing artifacts.
        }
        shadow {
            enabled = false
        }
    }

    layerrule = blur on, blur_popups on, ignore_alpha 0, xray on, match:namespace waybar
    layerrule = blur on, ignore_alpha 0, match:namespace swaync-control-center
    layerrule = blur on, ignore_alpha 0.5, match:namespace swaync-notification-window
  '';
}
