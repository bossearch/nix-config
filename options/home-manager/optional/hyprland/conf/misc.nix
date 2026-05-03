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
        vfr = true
        disable_hyprland_logo = true
        background_color = 0xFF${base00}
    }

    # fix wash out color on some apps
    render {
        cm_sdr_eotf = 2
        cm_fs_passthrough = 0
    }

    cursor {
        zoom_rigid = true
        zoom_detached_camera = false
        enable_hyprcursor = true
    }
  '';
}
