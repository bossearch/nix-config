{
  programs.yazi.settings = {
    mgr = {
      ratio = [1 3 4];
      show_hidden = true;
    };
    preview = {
      wrap = "yes";
    };
    opener = {
      edit = [
        {
          run = "sh -c \"~/.config/yazi/opener.sh \"$@\"\"";
          orphan = true;
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
          run = "sh -c \"~/.config/hypr/scripts/assets/mpv.sh \"$@\"\"";
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
          mime = "{audio,video}/*";
          run = "mediainfo";
        }
        {
          mime = "image/{png,jpg,jpeg,gif,bmp,webp,tiff,heic}";
          run = "mediainfo";
        }
        {
          mime = "application/subrip";
          run = "mediainfo";
        }
      ];
      prepend_previewers = [
        {
          mime = "{audio,video}/*";
          run = "mediainfo";
        }
        {
          mime = "image/{png,jpg,jpeg,gif,bmp,webp,tiff,heic,avif}";
          run = "mediainfo";
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
