{
  wayland.windowManager.hyprland.extraConfig = ''
    #################
    ### AUTOSTART ###
    #################

    exec-once = hyprlock --immediate --no-fade-in
    exec-once = ~/.config/hypr/scripts/startup-value.sh
    exec-once = ~/.config/gowall/daily-wallpaper.sh
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = blueman-applet
    exec-once = cliphist wipe
    exec-once = wl-paste --watch cliphist store
    exec-once = hyprpaper
  '';
}
