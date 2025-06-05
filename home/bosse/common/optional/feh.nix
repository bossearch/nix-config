{config, ...}: let
  mymonitor = builtins.all (m: m.height == 1440) config.monitors;
  size = {
    "3/4" =
      if mymonitor
      then "1920x1080"
      else "1440x810";
  };
in {
  programs.feh = {
    enable = true;
    keybindings = {
      prev_img = ["h" "Left"];
      next_img = ["l" "Right"];
      scroll_left = "H";
      scroll_down = "J";
      scroll_up = "K";
      scroll_right = "L";
      zoom_in = ["k" "plus"];
      zoom_out = ["j" "minus"];
      toggle_fullscreen = "f";
      quit = "q";
    };
  };
  xdg.desktopEntries.feh = {
    type = "Application";
    name = "feh";
    genericName = "Image Viewer";
    icon = "feh";
    exec = "feh --geometry ${size."3/4"} --auto-zoom --scale-down --image-bg black --start-at %u";
    comment = "Image viewer and cataloguer";
    terminal = false;
    noDisplay = true;
    categories = ["Graphics" "2DGraphics" "Viewer"];
    mimeType = [
      "image/bmp"
      "image/gif"
      "image/jpeg"
      "image/jpg"
      "image/pjpeg"
      "image/png"
      "image/tiff"
      "image/webp"
      "image/x-bmp"
      "image/x-pcx"
      "image/x-png"
      "image/x-portable-anymap"
      "image/x-portable-bitmap"
      "image/x-portable-graymap"
      "image/x-portable-pixmap"
      "image/x-tga"
      "image/x-xbitmap"
      "image/heic"
    ];
  };
}
