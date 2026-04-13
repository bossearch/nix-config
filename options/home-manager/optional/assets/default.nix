{
  homes,
  lib,
  ...
}: {
  home.file = {
    ".config/assets/sounds" = lib.mkIf (homes.notify != "none") {
      source = ./sounds;
      recursive = true;
    };
    ".config/mpv/fonts" = lib.mkIf homes.mpv {
      source = ./fonts;
      recursive = true;
    };
  };
}
