{
  config,
  lib,
  pkgs,
  ...
}: let
  myConf = "${config.home.homeDirectory}/.local/share/lutris/mylutris.conf";
in {
  home.packages = with pkgs; [
    winetricks
    wineWowPackages.staging
  ];

  programs.lutris = {
    enable = true;
    protonPackages = [
      pkgs.proton-ge-bin
    ];

    defaultWinePackage = pkgs.proton-ge-bin;
  };

  home.file.".config/lutris/lutris.conf".source =
    config.lib.file.mkOutOfStoreSymlink myConf;

  home.activation.initLutrisConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -f "${myConf}" ]; then
      mkdir -p "$(dirname "${myConf}")"
      cat > "${myConf}" << 'EOF'
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
    fi
  '';
}
