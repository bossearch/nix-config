{hosts, ...}: let
  enabled = hosts.gui.enable && hosts.gui.windowmanager == "hyprland";
in {
  programs.hyprland = {
    enable = enabled;
    xwayland.enable = true;
  };
}
