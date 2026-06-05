{homes, ...}: let
  mymonitor = builtins.all (m: m.height == 1440) homes.monitor;
  width =
    if mymonitor
    then 1280
    else 960;
  height =
    if mymonitor
    then 720
    else 540;
in {
  programs.yazi.settings = {
    mgr = {
      linemode = "size_and_mtime";
      ratio = [1 5 2];
      show_hidden = true;
    };
    preview = {
      wrap = "no";
      max_width = width;
      max_height = height;
    };
    opener = {
      edit = [
        {
          run = "sh -c \"echo \"$@\" > /tmp/yazi-edit-handoff; ya emit quit\" -- \"$@\"";
          orphan = true;
          for = "unix";
        }
      ];
      play = [
        {
          run = "sh -c \"~/.config/mpv/mpv.sh \"$@\"\"";
          orphan = true;
          for = "unix";
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
