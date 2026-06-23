{
  config,
  homes,
  hosts,
  ...
}: let
  footclient =
    if config.programs.foot.enable
    then "exec-once = ~/.config/foot/footclient.sh"
    else "";
  gowall =
    if homes.gowall
    then "exec-once = ~/.config/gowall/daily-wallpaper.sh"
    else "";
  retroarch =
    if homes.game.retroarch
    then "exec-once = cp ~/.cache/${hosts.username}/hyprpaper.png ~/.cache/${hosts.username}/retroarch.png"
    else "";
in {
  wayland.windowManager.hyprland.extraConfig = ''
    #################
    ### AUTOSTART ###
    #################

    exec-once = hyprlock --immediate-render --no-fade-in
    exec-once = hyprpaper
    exec-once = blueman-applet

    exec-once = cliphist wipe
    exec-once = wl-paste --watch cliphist store

    exec-once = ~/.config/hypr/scripts/startup-value.sh
    ${footclient}
    ${gowall}
    ${retroarch}
  '';
}
