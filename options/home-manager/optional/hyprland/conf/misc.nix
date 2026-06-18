{config, ...}: let
  base00 = config.colorScheme.palette.base00;
in {
  wayland.windowManager.hyprland.extraConfig = ''
    ############
    ### MISC ###
    ############

    ecosystem {
        no_update_news = true
        no_donation_nag = true
    }

    misc {
        # focus_on_activate = true
        allow_session_lock_restore = true
        disable_hyprland_logo = true
        background_color = 0xFF${base00}
    }

    debug {
        vfr = true
    }

    cursor {
        zoom_rigid = true
        zoom_detached_camera = false
        enable_hyprcursor = true
    }
  '';
}
