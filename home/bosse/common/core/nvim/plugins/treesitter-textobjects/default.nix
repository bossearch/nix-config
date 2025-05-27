{
  imports = [./repeat.nix];
  programs.nixvim.plugins.treesitter-textobjects = {
    enable = true;
    move = import ./move.nix;
  };
}
