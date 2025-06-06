{
  programs.mpv = {
    extraInput = ''
      MBTN_LEFT_DBL cycle pause; script-binding uosc/flash-pause-indicator
      MBTN_LEFT ignore
      #MBTN_LEFT_DBL script-message-to show-text " "
      TAB script-message-to uosc toggle-ui #@press
      TAB script-message-to uosc toggle-ui #@release
      MBTN_RIGHT script-binding evafast/speedup #@press
      MBTN_RIGHT script-binding evafast/slowdown #@release
      MBTN_MID script-binding skip-key #@click
      a script-binding skip-key
      MBTN_RIGHT script-binding uosc/menu-blurred #@click
      TAB script-binding stats/display-stats-toggle #@click
      g script-message playlist-view-toggle

      space cycle pause
      h seek -5 exact; script-binding uosc/flash-timeline
      j frame-back-step; script-binding uosc/flash-timeline
      k frame-step; script-binding uosc/flash-timeline
      l seek 5 exact; script-binding uosc/flash-timeline
      u no-osd add volume -1; script-binding uosc/flash-volume
      i no-osd add volume 1; script-binding uosc/flash-volume
      WHEEL_DOWN no-osd add volume -5; script-binding uosc/flash-volume
      WHEEL_UP no-osd add volume 5; script-binding uosc/flash-volume
      #ctrl+d script-binding autodeint/autodeint
      #ALT+b script-binding autosub/download_subs
      J add sub-scale +0.05
      K add sub-scale -0.05
      H add sub-delay -0.1
      L add sub-delay  0.1
      O script-binding uosc/show-in-directory
      #Q ignore
      ctrl+q quit

      ### UOSC Menu Config ###
      o script-binding uosc/open-file                                                 #! File > Open File
      p script-binding uosc/playlist                                                  #! File > Playlist
      ; script-binding memo-history                                                   #! File > History
      Ctrl+c script-binding uosc/copy-to-clipboard                                    #! File > Copy Link
      Ctrl+v script-binding uosc/paste                                                #! File > Paste Link
      # script-binding uosc/open-config-directory                                     #! File > Settings
      / script-binding console/enable                                                 #! File > Console
      # script-binding uosc/chapters                                                  #! Video > Chapters > List Chapters
      # script-binding chapters/add_chapter                                           #! Video > Chapters > Add Chapters
      # script-binding chapters/remove_chapter                                        #! Video > Chapters > Remove Chapters
      # script-binding chapters/edit_chapter                                          #! Video > Chapters > Edit Chapters
      # script-binding chapters/write_chapters                                        #! Video > Chapters > Save Chapters
      # apply-profile 4k60;show-text "Profile: 4K60"                                  #! Video > Profiles > Movie > 4K60
      # apply-profile 4k30;show-text "Profile: 4K30"                                  #! Video > Profiles > Movie > 4K30
      # apply-profile 2k60;show-text "Profile: 2K60"                                  #! Video > Profiles > Movie > 2K60
      # apply-profile 2k30;show-text "Profile: 2K30"                                  #! Video > Profiles > Movie > 2K30
      # apply-profile fhd60;show-text "Profile: FHD60"                                #! Video > Profiles > Movie > FHD60
      # apply-profile fhd30;show-text "Profile: FHD30"                                #! Video > Profiles > Movie > FHD30
      # apply-profile hd60;show-text "Profile: HD60"                                  #! Video > Profiles > Movie > HD60
      # apply-profile hd30;show-text "Profile: HD30"                                  #! Video > Profiles > Movie > HD30
      # apply-profile sd;show-text "Profile: SD"                                      #! Video > Profiles > Movie > SD
      # apply-profile anime4k60;show-text "Profile: Anime-4K60"                       #! Video > Profiles > Anime > 4K60
      # apply-profile anime4k30;show-text "Profile: Anime-4K30"                       #! Video > Profiles > Anime > 4K30
      # apply-profile anime2k60;show-text "Profile: Anime-2K60"                       #! Video > Profiles > Anime > 2K60
      # apply-profile anime2k30;show-text "Profile: Anime-2K30"                       #! Video > Profiles > Anime > 2K30
      # apply-profile animefhd60;show-text "Profile: Anime-FHD60"                     #! Video > Profiles > Anime > FHD60
      # apply-profile animefhd30;show-text "Profile: Anime-FHD30"                     #! Video > Profiles > Anime > FHD30
      # apply-profile animehd60;show-text "Profile: Anime-HD60"                       #! Video > Profiles > Anime > HD60
      # apply-profile animehd30;show-text "Profile: Anime-HD30"                       #! Video > Profiles > Anime > HD30
      # apply-profile animesd;show-text "Profile: Anime-SD"                           #! Video > Profiles > Anime > SD
      # script-binding uosc_video_settings/open-menu                                  #! Video > Video settings
      # script-binding uosc/video                                                     #! Video > Select Video Track
      # script-binding uosc/audio                                                     #! Audio > Select Audio Track
      # script-binding uosc/audio-device                                              #! Audio > Select Audio Device
      # script-binding uosc/subtitles                                                 #! Subtitles > Select
      # script-binding uosc/load-subtitles                                            #! Subtitles > Load
      # script-binding auto_sync_subs                                                 #! Subtitles > Sync
      # script-binding uosc_subtitle_settings/open-menu                               #! Subtitles > Subtitle settings
      ? script-binding uosc/keybinds                                                  #! Keybinds
      # script-binding uosc_screenshot/open-menu                                      #! Screenshot
      Ctrl+p script-message-to command_palette show-command-palette "Command Palette" #! Command Palette
    '';
  };
}
