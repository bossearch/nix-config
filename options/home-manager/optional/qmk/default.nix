{
  hosts,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./assets
  ];
  home.packages = lib.mkIf hosts.udevqmk [
    pkgs.unstable.qmk
  ];
}
