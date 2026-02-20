{
  homes,
  lib,
  ...
}: {
  home.file.".config/dunst/sound" = lib.mkIf homes.dunst {
    source = ./assets;
  };
}
