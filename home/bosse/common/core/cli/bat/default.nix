{...}: {
  imports = [
    ./tokyonight_night.nix
  ];
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "tokyonight_night";
    };
  };
}
