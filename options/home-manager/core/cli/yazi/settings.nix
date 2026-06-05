{
  programs.yazi.settings = {
    mgr = {
      linemode = "size_and_mtime";
      ratio = [1 5 2];
      show_hidden = true;
    };
    preview = {
      wrap = "yes";
    };
    opener = {
      edit = [
        {
          run = "sh -c \"echo \"$@\" > /tmp/yazi-edit-handoff; ya emit quit\" -- \"$@\"";
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
          run = "sh -c \"~/.config/mpv/mpv.sh \"$@\"\"";
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
          mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
          run = "ouch";
        }
      ];
    };
  };
}
