{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      feh = ["feh.desktop"];
      firefox = ["firefox.desktop"];
      mpv = ["mpv.desktop"];
      nautilus = ["nautilus-autorun-software.desktop"];
      nvim = ["nvim.desktop"];
      transmission = ["transmission.desktop"];
      yazi = ["yazi.desktop"];
      zathura = ["org.pwmt.zathura.desktop"];
      xdm = ["xdm.desktop"];
    in {
      # Feh
      "image/avif" = feh;
      "image/bmp" = feh;
      "image/gif" = feh;
      "image/heif" = feh;
      "image/jpeg" = feh;
      "image/png" = feh;
      "image/tiff" = feh;
      "image/vnd.zbrush.pcx" = feh;
      "image/webp" = feh;
      "image/x-portable-anymap" = feh;
      "image/x-portable-bitmap" = feh;
      "image/x-portable-graymap" = feh;
      "image/x-portable-pixmap" = feh;
      "image/x-tga" = feh;
      "image/x-xbitmap" = feh;

      # Firefox
      "application/xhtml+xml" = firefox;
      "application/vnd.mozilla.xul+xml" = firefox;
      "application/xml" = firefox;

      # MPV
      "application/x-shorten" = mpv;
      "application/sdp" = mpv;
      "application/smil+xml" = mpv;
      "application/x-cue" = mpv;
      "application/vnd.apple.mpegurl" = mpv;
      "application/vnd.ms-asf" = mpv;
      "application/mxf" = mpv;
      "application/x-matroska" = mpv;
      "application/vnd.rn-realmedia" = mpv;
      "application/ogg" = mpv;

      "audio/x-ape" = mpv;
      "audio/AMR" = mpv;
      "audio/flac" = mpv;
      "audio/webm" = mpv;
      "audio/ogg" = mpv;
      "audio/x-vorbis+ogg" = mpv;
      "audio/x-wavpack" = mpv;
      "audio/vnd.wave" = mpv;
      "audio/mp2" = mpv;
      "audio/mp4" = mpv;
      "audio/aac" = mpv;
      "audio/x-musepack" = mpv;
      "audio/vnd.dts" = mpv;
      "audio/vnd.rn-realaudio" = mpv;
      "audio/mpeg" = mpv;
      "audio/x-mpegurl" = mpv;
      "audio/x-matroska" = mpv;
      "audio/vnd.dts.hd" = mpv;
      "audio/x-ms-wma" = mpv;
      "audio/x-tta" = mpv;
      "audio/ac3" = mpv;
      "audio/x-adpcm" = mpv;
      "audio/x-scpls" = mpv;
      "audio/x-ms-asx" = mpv;
      "audio/x-aiff" = mpv;

      "video/x-ms-wmv" = mpv;
      "video/ogg" = mpv;
      "video/webm" = mpv;
      "video/mp2t" = mpv;
      "video/x-matroska" = mpv;
      "video/mp4" = mpv;
      "video/x-theora+ogg" = mpv;
      "video/dv" = mpv;
      "video/vnd.rn-realvideo" = mpv;
      "video/3gpp2" = mpv;
      "video/x-flic" = mpv;
      "video/mpeg" = mpv;
      "video/vnd.mpegurl" = mpv;
      "video/x-flv" = mpv;
      "video/x-ogm+ogg" = mpv;
      "video/3gpp" = mpv;
      "video/quicktime" = mpv;
      "video/vnd.avi" = mpv;

      # Neovim
      "application/x-shellscript" = nvim;
      "text/x-csrc" = nvim;
      "text/html" = nvim;
      "text/tcl" = nvim;
      "text/x-c++src" = nvim;
      "text/x-tex" = nvim;
      "text/x-pascal" = nvim;
      "text/x-java" = nvim;
      "text/x-chdr" = nvim;
      "text/x-moc" = nvim;
      "text/x-makefile" = nvim;
      "text/x-c++hdr" = nvim;
      "text/plain" = nvim;

      # Yazi
      "inode/directory" = yazi;

      # Zathura
      "application/oxps" = zathura;
      "application/pdf" = zathura;
      "application/postscript" = zathura;
      "application/vnd.comicbook+zip" = zathura;
      "application/vnd.comicbook-rar" = zathura;
      "application/x-cb7" = zathura;
      "application/x-cbt" = zathura;
      "application/x-fictionbook+xml" = zathura;

      "image/vnd.djvu" = zathura;
      "image/vnd.djvu+multipage" = zathura;
      "image/x-eps" = zathura;

      # misc
      "x-content/unix-software" = nautilus;
      "application/x-bittorrent" = transmission;
      "x-scheme-handler/magnet" = transmission;
      "x-scheme-handler/xdm-app" = xdm;
      "x-scheme-handler/xdm+app" = xdm;
    };
  };
}
