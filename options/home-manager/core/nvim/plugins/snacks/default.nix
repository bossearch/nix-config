{
  imports = [./toggle.nix];

  programs.nixvim.plugins.snacks = {
    enable = true;
    lazyLoad = {
      settings = {
        lazy = false;
      };
    };
    settings = {
      dashboard = import ./dashboard.nix;
      image = import ./image.nix;
      indent = import ./indent.nix;
      lazygit = import ./lazygit.nix;
      picker = import ./picker.nix;
      terminal = import ./terminal.nix;
      input = {enabled = true;};
      notifier = {enabled = true;};
      quickfile = {enabled = true;};
      scope = {enabled = true;};
      scroll = {enabled = false;};
      statuscolumn = {enabled = true;};
      words = {enabled = true;};
      zen = {enabled = true;};
    };
  };
}
