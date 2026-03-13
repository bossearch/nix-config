{
  wayland.windowManager.hyprland.extraConfig = ''
    #################
    ### AUTOSTART ###
    #################

    # 1. Session Setup
    exec-once = uwsm finalize
    exec-once = uwsm app -- systemctl --user restart xdg-desktop-portal

    # 2. Core Services
    exec-once = hyprlock --immediate --no-fade-in
    exec-once = hyprpaper
    exec-once = blueman-applet

    # 3. Clipboard Management
    exec-once = cliphist wipe
    exec-once = wl-paste --watch cliphist store

    # 4. Custom Scripts
    exec-once = ~/.config/hypr/scripts/startup-value.sh
    exec-once = ~/.config/gowall/daily-wallpaper.sh
  '';
}
