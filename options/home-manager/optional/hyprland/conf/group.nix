{config, ...}: let
  base0F = config.colorScheme.palette.base0F;
  base05 = config.colorScheme.palette.base05;
in {
  wayland.windowManager.hyprland.extraLuaFiles = {
    "lua.group" = {
      autoLoad = true;
      content = ''
        ---------------
        ---- GROUP ----
        ---------------

        hl.config({
            group = {
                col = {
                    border_active = "rgb(${base0F})",
                    border_inactive = "rgb(${base05})",
                },
                groupbar = {
                    enabled = false,
                },
            },
        })
      '';
    };
  };
}
