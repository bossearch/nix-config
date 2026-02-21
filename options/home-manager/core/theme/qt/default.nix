{
  hosts,
  lib,
  mylib,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.file.".config/Kvantum/kvantum.kvconfig" = lib.mkIf hosts.gui.enable {
    text = ''
      [General]
      theme=KvMyColors
    '';
  };
}
