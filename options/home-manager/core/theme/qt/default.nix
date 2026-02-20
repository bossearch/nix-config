{
  hosts,
  lib,
  ...
}: {
  imports = [
    ./KvMyColors
    ./kdeglobals.nix
    ./qt5ct.nix
  ];

  home.file.".config/Kvantum/kvantum.kvconfig" = lib.mkIf hosts.gui.enable {
    text = ''
      [General]
      theme=KvMyColors
    '';
  };
}
