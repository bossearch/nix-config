{config, ...}: let
  base0F = config.colorScheme.palette.base0F;
  base05 = config.colorScheme.palette.base05;
in {
  wayland.windowManager.hyprland.extraConfig = ''
    #############
    ### GROUP ###
    #############

    # https://wiki.hypr.land/Configuring/Variables/#group
    group {
      col.border_active = rgb(${base0F})
      col.border_inactive = rgb(${base05})
      groupbar {
        enabled = false
      }
    }
  '';
}
