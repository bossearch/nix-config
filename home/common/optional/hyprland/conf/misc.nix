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
  '';
}
