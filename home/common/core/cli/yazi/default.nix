{pkgs, ...}: {
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
    ./theme.nix
  ];
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi;
    initLua = ''
      require("full-border"):setup({
        type = ui.Border.ROUNDED,
      })
      require("git"):setup()
      require("no-status"):setup()
    '';
  };
}
