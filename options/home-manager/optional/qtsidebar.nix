{
  config,
  hosts,
  lib,
  ...
}: let
  homeDir = "${config.home.homeDirectory}";
  shortcuts = "file://${homeDir}/Desktop, file://${homeDir}/Documents, file://${homeDir}/Downloads, file://${homeDir}/Music, file://${homeDir}/Pictures, file://${homeDir}/Projects, file://${homeDir}/Public, file://${homeDir}/Videos";
in {
  home = lib.mkIf hosts.gui.enable {
    activation.shortcuts = lib.hm.dag.entryAfter ["writeBoundary"] ''
      QT_CONF="$HOME/.config/QtProject.conf"
      mkdir -p "$(dirname "$QT_CONF")"
      touch "$QT_CONF"

      sed -i '/^shortcuts=/d' "$QT_CONF"
      if ! grep -q "\[FileDialog\]" "$QT_CONF"; then
        echo -e "\n[FileDialog]" >> "$QT_CONF"
      fi
      sed -i '/\[FileDialog\]/a shortcuts=${shortcuts}' "$QT_CONF"
    '';
    file = {
      "${config.xdg.dataHome}/user-places.xbel".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE xbel>
        <xbel xmlns:bookmark="http://www.freedesktop.org/standards/desktop-bookmarks" xmlns:kdeparent="http://www.kde.org/standards/kdeparentbookmarks" xmlns:mime="http://www.freedesktop.org/standards/shared-mime-info">
         <bookmark href="file://${homeDir}/Desktop">
          <title>Desktop</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="user-desktop"/>
           </metadata>
          </info>
         </bookmark>
         <bookmark href="file://${homeDir}/Documents">
          <title>Documents</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="folder-documents"/>
           </metadata>
          </info>
         </bookmark>
         <bookmark href="file://${homeDir}/Downloads">
          <title>Downloads</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="folder-download"/>
           </metadata>
          </info>
         </bookmark>
         <bookmark href="file://${homeDir}/Music">
          <title>Music</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="folder-music"/>
           </metadata>
          </info>
         </bookmark>
         <bookmark href="file://${homeDir}/Pictures">
          <title>Pictures</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="folder-images"/>
           </metadata>
          </info>
         </bookmark>
         <bookmark href="file://${homeDir}/Projects">
          <title>Projects</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="folder-development"/>
           </metadata>
          </info>
         </bookmark>
         <bookmark href="file://${homeDir}/Public">
          <title>Public</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="folder-public"/>
           </metadata>
          </info>
         </bookmark>
         <bookmark href="file://${homeDir}/Videos">
          <title>Videos</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="folder-videos"/>
           </metadata>
          </info>
         </bookmark>
         <info>
          <metadata owner="http://www.kde.org">
           <kde_places_version>4</kde_places_version>
           <withBaloo>true</withBaloo>
           <GroupState-SearchFor-IsHidden>false</GroupState-SearchFor-IsHidden>
           <GroupState-RecentlySaved-IsHidden>true</GroupState-RecentlySaved-IsHidden>
          </metadata>
         </info>
         <bookmark href="file://${homeDir}">
          <title>Home</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="user-home"/>
           </metadata>
           <metadata owner="http://www.kde.org">
            <isSystemItem>true</isSystemItem>
           </metadata>
          </info>
         </bookmark>
         <bookmark href="remote:/">
          <title>Network</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="folder-network"/>
           </metadata>
           <metadata owner="http://www.kde.org">
            <isSystemItem>true</isSystemItem>
           </metadata>
          </info>
         </bookmark>
         <bookmark href="trash:/">
          <title>Trash</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="user-trash"/>
           </metadata>
           <metadata owner="http://www.kde.org">
            <isSystemItem>true</isSystemItem>
           </metadata>
          </info>
         </bookmark>
        </xbel>
      '';
    };
  };
}
