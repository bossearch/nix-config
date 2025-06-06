{pkgs, ...}: {
  programs.neomutt = {
    enable = true;
    package = pkgs.unstable.neomutt;
    vimKeys = true;
  };
}
