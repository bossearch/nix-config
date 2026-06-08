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
      # change-list glsl-shaders clr ""; apply-profile 4k; show-text "Profile: 4K"               #! Video > Profiles > Movie-4K
      # change-list glsl-shaders clr ""; apply-profile 2k; show-text "Profile: 2K"               #! Video > Profiles > Movie-2K
      # change-list glsl-shaders clr ""; apply-profile fhd; show-text "Profile: FHD"             #! Video > Profiles > Movie-FHD
      # change-list glsl-shaders clr ""; apply-profile hd; show-text "Profile: HD"               #! Video > Profiles > Movie-HD
      # change-list glsl-shaders clr ""; apply-profile sd; show-text "Profile: SD"               #! Video > Profiles > Movie-SD
      # change-list glsl-shaders clr ""; apply-profile anime4k; show-text "Profile: Anime-4K"    #! Video > Profiles > Anime-4K
      # change-list glsl-shaders clr ""; apply-profile anime2k; show-text "Profile: Anime-2K"    #! Video > Profiles > Anime-2K
      # change-list glsl-shaders clr ""; apply-profile animefhd; show-text "Profile: Anime-FHD"  #! Video > Profiles > Anime-FHD
      # change-list glsl-shaders clr ""; apply-profile animehd; show-text "Profile: Anime-HD"    #! Video > Profiles > Anime-HD
      # change-list glsl-shaders clr ""; apply-profile animesd; show-text "Profile: Anime-SD"    #! Video > Profiles > Anime-SD
      # change-list glsl-shaders clr ""; show-text "No Profile"                                  #! Video > Profiles > No Profile
      # script-binding uosc_video_settings/open-menu                                             #! Video > Video settings
      # script-binding uosc/video                                                                #! Video > Select video track
      # script-binding uosc/audio                                                                #! Audio > Select audio track
      # script-binding uosc/audio-device                                                         #! Audio > Select audio device
      # script-binding uosc_audio_filter/open-menu                                               #! Audio > Select audio filter
      # script-binding sync_to_audio                                                             #! Subtitle > Sync to audio
      # script-binding sync_to_internal_sub                                                      #! Subtitle > Sync to internal sub
      # script-binding subtitle_lines/list_subtitles                                             #! Subtitle > Sub history
      # script-binding subtitle_lines/list_secondary_subtitles                                   #! Subtitle > Sub alt history
      # script-binding uosc_subtitle_settings/open-menu                                          #! Subtitle > Subtitle settings
      O script-binding uosc/show-in-directory                                                    #! Misc > Open file manager
      Ctrl+c script-binding uosc/copy-to-clipboard                                               #! Misc > Copy Link
      Ctrl+v script-binding uosc/paste                                                           #! Misc > Paste Link
      / script-binding console/enable                                                            #! Misc > Console
      ? script-binding uosc/keybinds                                                             #! Misc > Keybinds
    '';
  };
}
