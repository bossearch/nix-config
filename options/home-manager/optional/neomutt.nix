{
  homes,
  pkgs,
  ...
}: {
  programs.neomutt = {
    enable = homes.neomutt;
    package = pkgs.neomutt;
    vimKeys = true;
  };
}
