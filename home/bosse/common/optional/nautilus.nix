{
  config,
  lib,
  pkgs,
  ...
}: let
  Home_dir = "${config.home.homeDirectory}/{Desktop,Downloads,Documents,Pictures,Videos}";
in {
  home.packages = with pkgs; [
    nautilus
    dconf
    sushi
    # varia
  ];

  dconf.settings = {
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

  home.activation.homedir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${Home_dir}" ];  then
      ${pkgs.coreutils}/bin/mkdir -p ${Home_dir}
    fi
  '';

  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///home/bosse/Desktop Desktop
    file:///home/bosse/Downloads Downloads
    file:///home/bosse/Documents Documents
    file:///home/bosse/Pictures Pictures
    file:///home/bosse/Videos Videos
    file:///home/bosse/.local/share/Vaults Vaults
  '';

  home.file.".config/user-dirs.dirs".text = ''
    XDG_DESKTOP_DIR="$HOME/Desktop"
    XDG_DOCUMENTS_DIR="$HOME/Documents"
    XDG_DOWNLOAD_DIR="$HOME/Downloads"
    XDG_PICTURES_DIR="$HOME/Pictures"
    XDG_VIDEOS_DIR="$HOME/Videos"
  '';
}
