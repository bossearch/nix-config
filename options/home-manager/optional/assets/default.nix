{
  homes,
  lib,
  ...
}: {
  home.file = {
    ".config/assets/sounds" = lib.mkIf homes.dunst {
      source = ./sounds;
      recursive = true;
    };
    ".config/mpv/fonts" = lib.mkIf homes.mpv {
      source = ./fonts;
      recursive = true;
    };
  };
}
