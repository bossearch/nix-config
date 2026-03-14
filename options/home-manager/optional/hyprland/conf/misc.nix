{
  wayland.windowManager.hyprland.extraConfig = ''
    ############
    ### MISC ###
    ############

    ecosystem {
        no_update_news = true
        no_donation_nag = true
    }

    misc {
    #    focus_on_activate = true
        allow_session_lock_restore = true
        vfr = true
    }

    # fix wash out color on some apps
    render {
        cm_sdr_eotf = 2
        cm_fs_passthrough = 0
    }

  '';
}
