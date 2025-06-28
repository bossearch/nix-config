{
  wayland.windowManager.hyprland.extraConfig = ''
    #################
    ### AUTOSTART ###
    #################

    exec-once = ~/.config/hypr/scripts/hyprpaper.sh
    exec-once = ~/.config/hypr/scripts/startup-value.sh
    exec-once = blueman-applet
    exec-once = cliphist wipe
    exec-once = wl-paste --watch cliphist store
  '';
}
