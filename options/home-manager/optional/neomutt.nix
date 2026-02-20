{
  homes,
  pkgs,
  ...
}: {
  programs.neomutt = {
    enable = homes.neomutt;
    package = pkgs.unstable.neomutt;
    vimKeys = true;
  };
}
