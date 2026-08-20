{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.permission" = {
      autoLoad = true;
      content = ''
        --------------------
        ---- PERMISSION ----
        --------------------

        hl.config({
            ecosystem = {
                enforce_permissions = true,
            },
        })

        hl.permission({
            binary = "${lib.getExe pkgs.grim}",
            type = "screencopy",
            mode = "allow"
        })

        hl.permission({
            binary = "${lib.getExe pkgs.hyprlock}",
            type = "screencopy",
            mode = "allow"
        })

        hl.permission({
            binary = "${lib.getExe pkgs.hyprpicker}",
            type = "screencopy",
            mode = "allow"
        })

        hl.permission({
            binary = "${pkgs.xdg-desktop-portal-hyprland}/libexec/.xdg-desktop-portal-hyprland-wrapped",
            type = "screencopy",
            mode = "allow"
        })
      '';
    };
  };
}
