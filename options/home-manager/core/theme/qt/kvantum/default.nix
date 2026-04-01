{
  homes,
  hosts,
  lib,
  mylib,
  ...
}: let
  enabled = hosts.gui.enable && homes.qtstyle == "kvantum";
in {
  imports = mylib.autoimport ./.;

  home = lib.mkIf enabled {
    file.".config/Kvantum/kvantum.kvconfig" = {
      text = ''
        [General]
        theme=KvMyColors
      '';
    };
  };
}
