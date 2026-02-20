{
  wayland.windowManager.hyprland.extraConfig = ''
    #################
    ### AUTOSTART ###
    #################

    exec-once = ~/.config/hypr/scripts/startup-value.sh
    exec-once = ~/.config/gowall/daily-wallpaper.sh
    exec-once = blueman-applet
    exec-once = cliphist wipe
    exec-once = wl-paste --watch cliphist store
    exec-once = hyprpaper
    exec-once = hyprlock
  '';
}
