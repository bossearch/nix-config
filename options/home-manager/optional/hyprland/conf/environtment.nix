{
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.environtment" = {
      autoLoad = true;
      content = ''
        ----------------------
        ---- ENVIRONTMENT ----
        ----------------------

        hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
        hl.env("XDG_SESSION_DESKTOP", "Hyprland")
        hl.env("XDG_SESSION_TYPE", "wayland")

        hl.env("GDK_BACKEND", "wayland")
        hl.env("QT_QPA_PLATFORM", "wayland;xcb")
        hl.env("SDL_VIDEODRIVER", "wayland")

        hl.env("MOZ_ENABLE_WAYLAND", "1")
        hl.env("WLR_NO_HARDWARE_CURSORS", "1")
        hl.env("NIXOS_OZONE_WL", "1")
      '';
    };
  };
}
