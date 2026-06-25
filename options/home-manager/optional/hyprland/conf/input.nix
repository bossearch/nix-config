{hosts, ...}: let
  keyboard =
    if hosts.hostname == "silvia"
    then ''
      device {
          name = foostan-corne
          kb_options = lv3:ralt_switch
          repeat_rate = 40
          repeat_delay = 400
      }
    ''
    else ''
      device {
          name = at-translated-set-2-keyboard
          kb_options = lv3:ralt_switch
          repeat_rate = 40
          repeat_delay = 400
      }
    '';
in {
  wayland.windowManager.hyprland.extraConfig = ''
    #############
    ### INPUT ###
    #############

    # https://wiki.hypr.land/Configuring/Variables/#input
    input {
        kb_layout = us
        follow_mouse = 2
        focus_on_close = 0
        float_switch_override_focus = 0
        touchpad {
            natural_scroll = false
        }
    }

    # https://wiki.hypr.land/Configuring/Variables/#gestures
    gestures {
    }

    # Example per-device config
    # See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
    # mice
    device {
        name = corsair-corsair-gaming-scimitar-pro-rgb-mouse-1
        sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat
    }
    device {
        name = foostan-corne-mouse
        sensitivity = 0.5 # -1.0 - 1.0, 0 means no modification.
        accel_profile = flat
    }
    # keyboard
    ${keyboard}
  '';
}
