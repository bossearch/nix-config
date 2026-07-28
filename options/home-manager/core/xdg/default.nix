{
  config,
  hosts,
  pkgs,
  ...
}: {
  xdg = {
    enable = true;
    mimeApps = import ./mime.nix {inherit hosts;};
    portal = import ./portal.nix {inherit hosts pkgs;};
    userDirs = import ./user-dirs.nix {inherit config;};
  };
}
