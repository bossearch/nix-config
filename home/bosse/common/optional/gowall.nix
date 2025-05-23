{
  config,
  lib,
  pkgs,
  ...
}: let
  Gowall_dir = "${config.home.homeDirectory}/Pictures/gowall";
in {
  home.activation.gowalldir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${Gowall_dir}" ];  then
      ${pkgs.coreutils}/bin/mkdir -p ${Gowall_dir}
    fi
  '';
}
