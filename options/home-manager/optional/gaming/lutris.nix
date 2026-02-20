{
  config,
  homes,
  lib,
  pkgs,
  ...
}: {
  programs.lutris = {
    enable = homes.game.lutris;
    extraPackages = with pkgs; [gamescope gamemode];
    winePackages = [pkgs.wineWowPackages.staging];
  };

  home.activation = lib.mkIf homes.game.lutris {
    setupLutrisConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      config_file="${config.home.homeDirectory}/.config/lutris/lutris.conf"
      mkdir -p "$(dirname "$config_file")"

      cat > "$config_file" << 'EOF'
        [services]
        gog = False
        egs = False
        ea_app = False
        ubisoft = False
        steam = False

        [lutris]
        library_ignores =
        migration_version = 15
        width = 1280
        height = 673
        maximized = True
        selected_category = category:all
        view_type = list
        icon_type_listview = banner
        side_panel_visible = False
        filter_installed = False
        show_advanced_options = True

        [list view]
        name_column_width = 200
        year_column_width = 60
        runner_column_width = 120
        platform_column_width = 120
        lastplayed_column_width = 220
        playtime_column_width = 200
        installedat_column_width = 120
      EOF
    '';
  };
}
