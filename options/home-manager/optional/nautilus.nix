{
  config,
  homes,
  hosts,
  lib,
  pkgs,
  ...
}: let
  Home_dir =
    if hosts.hostname == "silvia"
    then "${config.home.homeDirectory}/{Downloads/{Torrent,LocalSend},Pictures/Screenshots,Videos/Screenrecords,.cache/${hosts.username}}"
    else "${config.home.homeDirectory}/{Pictures/Screenshots,Videos/Screenrecords,.cache/${hosts.username}}";
in {
  home = lib.mkMerge [
    {
      activation.homedir = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -d "${Home_dir}" ];  then
          ${pkgs.coreutils}/bin/mkdir -p ${Home_dir}
        fi
      '';
    }
    (lib.mkIf homes.nautilus {
      packages = with pkgs; [
        nautilus
        dconf
        sushi
        veracrypt
      ];
      file = {
        ".config/gtk-3.0/bookmarks".text = ''
          file://${config.home.homeDirectory}/Desktop Desktop
          file://${config.home.homeDirectory}/Documents Documents
          file://${config.home.homeDirectory}/Downloads Downloads
          file://${config.home.homeDirectory}/Music Music
          file://${config.home.homeDirectory}/Pictures Pictures
          file://${config.home.homeDirectory}/Projects Projects
          file://${config.home.homeDirectory}/Public Public
          file://${config.home.homeDirectory}/Videos Videos
        '';
      };
    })
  ];

  dconf.settings = lib.mkIf homes.nautilus {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
    };
  };
}
