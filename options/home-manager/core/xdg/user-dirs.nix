{config, ...}: {
  enable = true;
  createDirectories = true;
  setSessionVariables = false;
  desktop = "${config.home.homeDirectory}/Desktop";
  documents = "${config.home.homeDirectory}/Documents";
  download = "${config.home.homeDirectory}/Downloads";
  music = "${config.home.homeDirectory}/Music";
  pictures = "${config.home.homeDirectory}/Pictures";
  projects = "${config.home.homeDirectory}/Projects";
  publicShare = "${config.home.homeDirectory}/Public";
  templates = null;
  videos = "${config.home.homeDirectory}/Videos";
}
