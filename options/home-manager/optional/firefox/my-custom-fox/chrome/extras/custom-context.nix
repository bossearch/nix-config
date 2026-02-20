{
  homes,
  hosts,
  lib,
  ...
}: {
  home.file.".mozilla/firefox/${hosts.username}/chrome/extras/custom-context.css" = lib.mkIf homes.firefox.enable {
    text = ''
      /*on tab*/
      #context_moveTabToNewGroup,
      #context_ungroupTab,
      #context_ungroupTab + menuseparator,

      #context_playTab,
      #context_playSelectedTabs,
      #context_toggleMuteTab,
      #context_toggleMuteSelectedTabs,
      #context_unloadTab,

      #context_askChat,
      #context_askChat + menuseparator,

      #context_bookmarkTab,
      #context_moveTabOptions,
      #context_reopenInContainer,
      #context_selectAllTabs,
      #context_closeTab,

      /*on page*/
      #context-openlinkinusercontext-menu,
      #context-bookmarklink,
      #context-savepage,
      #context-savelink,
      #context-sep-selectall,
      #context-sep-screenshots,
      /*#context-ask-chat,*/
      #context-ask-chat + menuseparator,
      #context-viewsource,

      /*image*/
      #context-copyimage,
      #context-sendimage,

      /*video*/
      #context-media-play,
      #context-media-pause,
      #context-media-mute,
      #context-media-unmute,
      #context-media-playbackrate,
      #context-media-loop,
      #context-video-fullscreen,
      #context-media-showcontrols,
      #context-media-sep-video-commands,

      #context-viewvideo,
      #context-video-pictureinpicture,
      #context-media-sep-commands,

      #context-video-saveimage,
      #context-savevideo,
      #context-copyvideourl,
      #context-sendvideo,
      #context-sep-setbackground,

      #context-inspect,
      #context-inspect-a11y {
        display: none !important;
      }
    '';
  };
}
