{config, ...}: let
  base01 = config.lib.stylix.colors.base01;
  base03 = config.lib.stylix.colors.base03;
in {
  wayland.windowManager.hyprland.extraConfig = ''
    ###############
    ### GENERAL ###
    ###############

    # https://wiki.hyprland.org/Configuring/Variables/#general
    general {
        gaps_in = 4
        gaps_out = 8

        border_size = 2

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        col.active_border = rgb(${base01})
        col.inactive_border = rgb(${base03})

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
    #    resize_on_border = true

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false

        layout = master
    }
  '';
}
