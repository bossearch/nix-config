{
  config,
  homes,
  ...
}: let
  gowall =
    if homes.gowall
    then "exec-once = ~/.config/gowall/daily-wallpaper.sh"
    else "";
  footclient =
    if config.programs.foot.enable
    then "exec-once = ~/.config/foot/footclient.sh"
    else "";
in {
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
    ${gowall}
    ${footclient}
  '';
}
