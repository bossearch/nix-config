{...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    ############
    ### MISC ###
    ############

    misc {
    #    focus_on_activate = true
        allow_session_lock_restore = true
        vfr = true
    }
  '';
}
