{
  wayland.windowManager.hyprland.extraConfig = ''
    #################
    ### AUTOSTART ###
    #################

    exec-once = hyprlock --immediate --no-fade-in
    exec-once = hyprpaper
    exec-once = blueman-applet

    exec-once = cliphist wipe
    exec-once = wl-paste --watch cliphist store

    exec-once = ~/.config/hypr/scripts/startup-value.sh
    exec-once = ~/.config/gowall/daily-wallpaper.sh
  '';
}
