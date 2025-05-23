{...}: {
  imports = [./KvTokyoNight];

  home.file.".config/Kvantum/kvantum.kvconfig" = {
    text = ''
      [General]
      theme=KvTokyoNight
    '';
  };
}
