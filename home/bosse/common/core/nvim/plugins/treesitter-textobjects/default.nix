{
  imports = [./repeat.nix];
  programs.nixvim.plugins.treesitter-textobjects = {
    enable = true;
    select = import ./select.nix;
    move = import ./move.nix;
  };
}
