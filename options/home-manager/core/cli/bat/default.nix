{
  imports = [./base16.nix];
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "my-base16";
    };
  };
}
