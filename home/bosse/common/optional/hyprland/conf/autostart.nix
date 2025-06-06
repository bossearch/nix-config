{
  wayland.windowManager.hyprland.extraConfig = ''
    #################
    ### AUTOSTART ###
    #################

    exec-once = ~/.config/hypr/scripts/startup-value.sh
    # exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    # exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    # exec-once = systemctl --user start xdg-desktop-portal-hyprland.service
    # exec-once = systemctl --user start polkit-gnome-authentication-agent-1.service
    exec-once = blueman-applet
    exec-once = cliphist wipe
    exec-once = wl-paste --watch cliphist store
    exec-once = hyprpm reload
    exec-once = hyprpaper
    exec-once = hyprlock
  '';
}
