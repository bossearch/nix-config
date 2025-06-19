{
  imports = [
    ./KvMyColors
    ./kdeglobals.nix
    ./qt5ct.nix
  ];

  home.file.".config/Kvantum/kvantum.kvconfig" = {
    text = ''
      [General]
      theme=KvMyColors
    '';
  };
}
