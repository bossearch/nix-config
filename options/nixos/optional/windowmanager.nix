{hosts, ...}: let
  wm = hosts.windowmanager;
in {
  programs.hyprland = {
    enable = wm == "hyprland";
    withUWSM = true;
    xwayland.enable = true;
  };
}
