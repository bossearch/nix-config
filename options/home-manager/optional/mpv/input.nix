{
  programs.mpv = {
    extraInput = ''
      MBTN_LEFT_DBL cycle pause
      MBTN_RIGHT script-binding uosc/menu
      MBTN_MID script-binding skip-key
      WHEEL_DOWN no-osd add volume -5; script-binding uosc/flash-volume
      WHEEL_UP no-osd add volume 5; script-binding uosc/flash-volume

      h seek -5 exact; script-binding uosc/flash-timeline
      j frame-back-step; script-binding uosc/flash-timeline
      k frame-step; script-binding uosc/flash-timeline
      l seek 5 exact; script-binding uosc/flash-timeline
      u add volume -5; script-binding uosc/flash-volume
      i add volume 5; script-binding uosc/flash-volume
      m add brightness -1
      , add brightness +1

      TAB script-binding stats/display-stats-toggle
      SPACE cycle pause
      DOWN add sub-scale +0.05
      UP add sub-scale -0.05
      LEFT add sub-delay -0.1
      RIGHT add sub-delay  0.1


      ### UOSC Menu Config ###
      # script-binding uosc/chapters                                                  #! Video > Chapters > List Chapters
      # script-binding chapters/add_chapter                                           #! Video > Chapters > Add Chapters
      # script-binding chapters/remove_chapter                                        #! Video > Chapters > Remove Chapters
      # script-binding chapters/edit_chapter                                          #! Video > Chapters > Edit Chapters
      # script-binding chapters/write_chapters                                        #! Video > Chapters > Save Chapters
      # apply-profile 4k;show-text "Profile: 4K"                                      #! Video > Profiles > Movie-4K
      # apply-profile 2k;show-text "Profile: 2K"                                      #! Video > Profiles > Movie-2K
      # apply-profile fhd;show-text "Profile: FHD"                                    #! Video > Profiles > Movie-FHD
      # apply-profile hd;show-text "Profile: HD"                                      #! Video > Profiles > Movie-HD
      # apply-profile sd;show-text "Profile: SD"                                      #! Video > Profiles > Movie-SD
      # apply-profile anime4k;show-text "Profile: Anime-4K"                           #! Video > Profiles > Anime-4K
      # apply-profile anime2k;show-text "Profile: Anime-2K"                           #! Video > Profiles > Anime-2K
      # apply-profile animefhd;show-text "Profile: Anime-FHD"                         #! Video > Profiles > Anime-FHD
      # apply-profile animehd;show-text "Profile: Anime-HD"                           #! Video > Profiles > Anime-HD
      # apply-profile animesd;show-text "Profile: Anime-SD"                           #! Video > Profiles > Anime-SD
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
