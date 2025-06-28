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
      interpolation = "yes";
      video-sync = "display-resample";
      tscale = "sphinx";
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
      sub-font-size = 40;
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
      #profiles
      "4k60" = {
        profile-desc = "4k60";
        profile-cond = "(width == 3840 and path:find('Videos/Movies/') and p[\"estimated-vf-fps\"] >= 31)";
        profile-restore = "copy";
        interpolation = "no";
        deband = "no";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/SSimDownscaler.glsl"
        ];
        linear-downscaling = "no";
      };

      "4k30" = {
        profile-desc = "4k30";
        profile-cond = "(width == 3840 and path:find('Videos/Movies/') and p[\"estimated-vf-fps\"] < 31)";
        profile-restore = "copy";
        deband = "no";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/SSimDownscaler.glsl"
        ];
        linear-downscaling = "no";
      };

      "2k60" = {
        profile-desc = "2k60";
        profile-cond = "(width == 2560 and path:find('Videos/Movies/') and p[\"estimated-vf-fps\"] >= 31)";
        profile-restore = "copy";
        interpolation = "no";
        deband = "no";
        glsl-shader = "~/.config/mpv/shaders/KrigBilateral.glsl";
      };

      "2k30" = {
        profile-desc = "2k60";
        profile-cond = "(width == 2560 and path:find('Videos/Movies/') and p[\"estimated-vf-fps\"] < 31)";
        profile-restore = "copy";
        deband = "no";
        glsl-shader = "~/.config/mpv/shaders/KrigBilateral.glsl";
      };

      "fhd60" = {
        profile-desc = "fhd60";
        profile-cond = "(width == 1920 and path:find('Videos/Movies/') and p[\"estimated-vf-fps\"] >= 31)";
        profile-restore = "copy";
        interpolation = "no";
        glsl-shader = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/FSR.glsl"
          "~/.config/mpv/shaders/SSimSuperRes.glsl"
        ];
      };
      "fhd30" = {
        profile-desc = "fhd30";
        profile-cond = "(width == 1920 and path:find('Videos/Movies/') and p[\"estimated-vf-fps\"] < 31)";
        profile-restore = "copy";
        glsl-shaders = [
          "~/.config/mpv/shaders/KrigBilateral.glsl"
          "~/.config/mpv/shaders/FSR.glsl"
          "~/.config/mpv/shaders/SSimSuperRes.glsl"
        ];
      };

      "lofi" = {
        profile-desc = "lofi";
        profile-cond = "path:find('Lofi/')";
        profile-restore = "copy";
        audio-device = "pipewire/alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo";
        volume = 0;
      };
    };
  };
}
