{
  wayland.windowManager.hyprland.extraConfig = ''
    #############
    ### INPUT ###
    #############

    # https://wiki.hyprland.org/Configuring/Variables/#input
    input {
        kb_layout = us
        follow_mouse = 2
        focus_on_close = 1
        float_switch_override_focus = 0
        touchpad {
            natural_scroll = false
        }
    }

    # https://wiki.hyprland.org/Configuring/Variables/#gestures
    gestures {
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
    # mice
    device {
        name = bosse’s-magic-mouse
        sensitivity = -0.2 # -1.0 - 1.0, 0 means no modification.
    }
    device {
        name = corsair-corsair-gaming-scimitar-pro-rgb-mouse-1
        sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat
    }
    device {
        name = foostan-corne-mouse
        sensitivity = 1 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat
      }

    # keyboard
    device {
        name = foostan-corne
        kb_options = lv3:ralt_switch
        repeat_rate = 30    # The repeat rate for held-down keys, in repeats per second.
        repeat_delay = 600  # Delay before a held-down key is repeated, in milliseconds.
    }
  '';
}
