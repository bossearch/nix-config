{
  hosts,
  pkgs,
  ...
}: let
  enabled = hosts.gui.enable;
in {
  enable = enabled;
  xdgOpenUsePortal = true;
  extraPortals = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];
  config = {
    common.default = ["gtk"];
    hyprland = {
      default = ["hyprland" "gtk"];
      "org.freedesktop.impl.portal.Screencast" = ["hyprland"];
      "org.freedesktop.impl.portal.Screenshot" = ["hyprland"];
    };
  };
}
