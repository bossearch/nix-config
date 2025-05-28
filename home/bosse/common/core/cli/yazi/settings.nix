{...}: {
  programs.yazi.settings = {
    manager = {
      ratio = [1 3 4];
      show_hidden = true;
    };
    preview = {
      wrap = "yes";
    };
    opener = {
      edit = [
        {
          run = "nvim \"$@\"";
          block = true;
          for = "unix";
        }
        {
          run = "nvim %*";
          block = true;
          for = "windows";
        }
      ];
      play = [
        {
          run = "mpv --player-operation-mode=pseudo-gui --input-ipc-server=/tmp/mpv-socket \"$@\"";
          orphan = true;
          for = "unix";
        }
        {
          run = "\"C:\\Program Files\\mpv.exe\" %*";
          orphan = true;
          for = "windows";
        }
      ];
      open = [
        {
          run = "xdg-open \"$@\"";
          desc = "Open";
        }
      ];
      extract = [
        {
          run = "ouch d -y \"$@\"";
          desc = "Extract here with ouch";
          for = "unix";
        }
        {
          run = "ouch d -y \"%*\"";
          desc = "Extract here with ouch";
          for = "windows";
        }
      ];
    };
    plugin = {
      prepend_preloaders = [
        {
          mime = "{audio,video,image}/*";
          run = "mediainfo";
        }
        # try comment setting above & uncomment settings below if mediainfo not work on avif
        # { mime = "image/avif"; run = "mediainfo"; }
        # {
        #   mime = "{audio,video}/*";
        #   run = "mediainfo";
        # }
        # {
        #   mime = "image/jpeg";
        #   run = "mediainfo";
        # }
        # {
        #   mime = "image/png";
        #   run = "mediainfo";
        # }
        # {
        #   mime = "image/gif";
        #   run = "mediainfo";
        # }
        # {
        #   mime = "image/webp";
        #   run = "mediainfo";
        # }
        {
          mime = "application/subrip";
          run = "mediainfo";
        }
      ];
      prepend_previewers = [
        {
          mime = "{audio,video,image}/*";
          run = "mediainfo";
        }
        # { mime = "image/avif"; run = "mediainfo"; }
        # {
        #   mime = "{audio,video}/*";
        #   run = "mediainfo";
        # }
        # {
        #   mime = "image/jpeg";
        #   run = "mediainfo";
        # }
        # {
        #   mime = "image/png";
        #   run = "mediainfo";
        # }
        # {
        #   mime = "image/gif";
        #   run = "mediainfo";
        # }
        # {
        #   mime = "image/webp";
        #   run = "mediainfo";
        # }
        {
          mime = "image/avif";
          run = "magick";
        }
        {
          mime = "application/subrip";
          run = "mediainfo";
        }
        {
          mime = "application/*zip";
          run = "ouch";
        }
        {
          mime = "application/x-tar";
          run = "ouch";
        }
        {
          mime = "application/x-bzip2";
          run = "ouch";
        }
        {
          mime = "application/x-7z-compressed";
          run = "ouch";
        }
        {
          mime = "application/x-rar";
          run = "ouch";
        }
        {
          mime = "application/x-xz";
          run = "ouch";
        }
      ];
    };
  };
}
