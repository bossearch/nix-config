{pkgs, ...}: {
  import = [./conf];

  home.packages = [
    pkgs.unstable.nchat
  ];

  xdg.desktopEntries.nchat = {
    type = "Application";
    name = "nchat";
    exec = "kitty -T nchat nchat";
    comment = "Open nchat with kitty";
  };
}
