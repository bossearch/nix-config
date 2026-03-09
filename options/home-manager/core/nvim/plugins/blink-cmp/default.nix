{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      wordnet
    ];
    plugins = {
      blink-cmp-dictionary.enable = true;
      blink-cmp-git.enable = true;
      blink-cmp-spell.enable = true;
      blink-copilot.enable = false;
      blink-ripgrep.enable = true;
      blink-cmp = {
        enable = true;
        lazyLoad = {
          settings = {
            cmp = "BlinkCmp";
          };
        };
        setupLspCapabilities = true;
        settings = import ./settings.nix;
      };
    };
  };
}
