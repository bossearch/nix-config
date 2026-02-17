{config, ...}: let
  wm = config.spec.windowmanager;
in {
  programs.hyprland = {
    enable = wm == "hyprland";
    withUWSM = true;
    xwayland.enable = true;
  };
}
