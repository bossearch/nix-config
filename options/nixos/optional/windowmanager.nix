{hosts, ...}: {
  programs.hyprland = {
    enable = hosts.gui.enable;
    xwayland.enable = true;
  };
}
