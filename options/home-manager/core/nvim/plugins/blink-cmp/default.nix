{pkgs, ...}: {
  programs.nixvim = {
    # packages for blink-cmp-words
    extraPackages = with pkgs; [
      wordnet
      fzy
    ];
    plugins = {
      blink-cmp-words.enable = true;
      blink-cmp-git.enable = true;
      blink-ripgrep.enable = true;
      blink-cmp = {
        enable = true;
        lazyLoad = {
          settings = {
            event = "InsertEnter";
          };
        };
        setupLspCapabilities = true;
        settings = import ./settings.nix;
      };
    };
  };
}
