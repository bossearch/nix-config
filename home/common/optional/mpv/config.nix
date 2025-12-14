{
  programs.mpv = {
    config = {
      # general
      fs = "no";
      keep-open = "always";
      save-position-on-quit = "yes";
      watch-later-dir = "~/.cache/mpv/watch-later";
      # write-filename-in-watch-later-config = "yes";
      # force-seekable = "yes";
      # input-default-bindings = "no";

      # osd
      osc = "yes";
      border = "no";
      osd-bar = "no";
      # osd-bold = "yes";
      osd-font-size = 40;
      osd-font = "Noto Sans SemiBold";
      osd-color = "#FFFFFFFF";
      osd-border-color = "#B3000000";
      osd-border-size = 2;

      # screenshot
      screenshot-sw = "yes";
      screenshot-format = "png";
      screenshot-high-bit-depth = "yes";
      screenshot-png-compression = 1;
      screenshot-dir = "~/Pictures/Screenshots";
      screenshot-template = "%F-%wH:%wM:%wS";

      # gpu_api
      gpu-api = "auto";
      profile = "gpu-hq";
      gpu-context = "wayland";
      gpu-shader-cache-dir = "~/.cache/mpv/gpu-shader";

      # hwdec
      hwdec = "vaapi";
      vo = "gpu";

      # interpolation
      interpolation = "no";
      video-sync = "display-resample";
      tscale = "sphinx"; # or oversample
      tscale-blur = 0.6991556596428412;
      tscale-radius = 1.0; #lower (e.g. 0.955) = sharper; higher (e.g. 1.005) = smoother
      tscale-clamp = 0.0;
      interpolation-preserve = "no";

      # deband
      deband = "yes";
      deband-iterations = 4;
      deband-threshold = 48;
      deband-range = 24;
      deband-grain = 16;

      # subtitles
      slang = "ind,ina,id,Indonesia,en,eng,English";
      sub-color = "#FFFFFFFF";
      sub-font = "Noto Sans SemiBold";
      sub-font-size = 36;
      sub-border-color = "#B3000000";
      sub-border-size = 2;
      # sub-border-style = "outline-and-shadow";
      sub-auto = "all";
      sub-fix-timing = "yes";
      # blend-subtitles = "yes";
      # sub-ass-override = "yes";
      sub-ass-override = "strip";
      # sub-ass-line-spacing = 3.6;
      demuxer-mkv-subtitle-preroll = "yes";

      # audio
      alang = "ja,jp,jpn,jap,Japanese,en,eng,English";
      # volume = 0;
      volume-max = 200;
      audio-channels = "auto";
      audio-file-auto = "fuzzy";
      audio-pitch-correction = "yes";
      audio-normalize-downmix = "yes";
      gapless-audio = "yes";
      audio-device = "pipewire/alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3";
      # mute = "yes";
      # af = "lavfi=[dynaudnorm=f=250:g=31:p=0.5:m=5:r=0.9:b=1]";
      # af = "lavfi=[dynaudnorm=g=3:f=250:r=0.9:p=0.9:m=10]";
      # af = "@dynaudnorm:lavfi=[dynaudnorm=g=5:f=250:r=0.9:p=0.5]";

      # misc
      script-opts = "youtube_sub-source_lang=en";
      hr-seek = "yes";
      hr-seek-framedrop = "no";
      target-colorspace-hint = "yes";
      # target-contrast = "auto";
      fbo-format = "rgba16f";
      # ytdl-format = "bestvideo[vcodec!=?vp9]+bestaudio/best";
      ytdl-format = "bestvideo[width<=?1920]+bestaudio/best";
    };
    profiles = {
      # profiles
      "4k" = {
        profile-desc = "4k";
        profile-cond = "(height >= 2160 and path:find('Videos/Movies/'))";
        profile-restore = "copy";
        deband = "no";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/SSimDownscaler.glsl"
        ];
        linear-downscaling = "no";
      };

      "2k" = {
        profile-desc = "2k";
        profile-cond = "(height >= 1440 and height < 2160 and path:find('Videos/Movies/'))";
        profile-restore = "copy";
        deband = "no";
        glsl-shader = "~/.config/mpv/shaders/KrigBilateral.glsl";
      };

      "fhd" = {
        profile-desc = "fhd";
        profile-cond = "(height >= 1080 and height < 1440 and path:find('Videos/Movies/'))";
        profile-restore = "copy";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/FSR.glsl"
          "~/.config/mpv/shaders/SSimSuperRes.glsl"
        ];
      };

      "hd" = {
        profile-desc = "hd";
        profile-cond = "(height >= 720 and height < 1080 and path:find('Videos/Movies/'))";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/FSRCNNX_x2_16-0-4-1_enhance.glsl"
          "~/.config/mpv/shaders/SSimSuperRes.glsl"
        ];
        scale-antiring = 0.6;
        dscale-antiring = 0.6;
        cscale-antiring = 0.6;
      };

      "sd" = {
        profile-desc = "sd";
        profile-cond = "(height < 720 and path:find('Videos/Movies/'))";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/FSRCNNX_x2_16-0-4-1_enhance.glsl"
          "~/.config/mpv/shaders/SSimSuperRes.glsl"
        ];
        scale-antiring = 0.8;
        dscale-antiring = 0.8;
        cscale-antiring = 0.8;
      };

      # anime profiles
      "anime4k" = {
        profile-desc = "anime4k";
        profile-cond = "(height >= 2160 and path:find('Videos/Anime/'))";
        profile-restore = "copy";
        deband = "no";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/SSimDownscaler.glsl"
        ];
        linear-downscaling = "no";
      };

      "anime2k" = {
        profile-desc = "anime2k";
        profile-cond = "(height >= 1440 and height < 2160 and path:find('Videos/Anime/'))";
        profile-restore = "copy";
        deband = "no";
        glsl-shader = "~/.config/mpv/shaders/KrigBilateral.glsl";
      };

      "animefhd" = {
        profile-desc = "animefhd";
        profile-cond = "(height >= 1080 and height < 1440 and path:find('Videos/Anime/'))";
        profile-restore = "copy";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/FSR.glsl"
          "~/.config/mpv/shaders/SSimSuperRes.glsl"
        ];
      };

      "animehd" = {
        profile-desc = "animehd";
        profile-cond = "(height >= 720 and height < 1080 and path:find('Videos/Anime/'))";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/FSRCNNX_x2_16-0-4-1_anime_enhance.glsl"
          "~/.config/mpv/shaders/A4K_Thin.glsl"
          "~/.config/mpv/shaders/SSimSuperRes.glsl"
        ];
        scale-antiring = 0.6;
        dscale-antiring = 0.6;
        cscale-antiring = 0.6;
      };

      "animesd" = {
        profile-desc = "animesd";
        profile-cond = "(height < 720 and path:find('Videos/Anime/'))";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/FSRCNNX_x2_16-0-4-1_anime_enhance.glsl"
          "~/.config/mpv/shaders/A4K_Thick.glsl"
          "~/.config/mpv/shaders/SSimSuperRes.glsl"
        ];
        scale-antiring = 0.8;
        dscale-antiring = 0.8;
        cscale-antiring = 0.8;
      };

      # other
      "lofi" = {
        profile-desc = "lofi";
        profile-cond = "path:find('Lofi/')";
        profile-restore = "copy";
        audio-device = "pipewire/alsa_output.pci-0000_08_00.6.analog-stereo";
        volume = 0;
      };
    };
  };
}
