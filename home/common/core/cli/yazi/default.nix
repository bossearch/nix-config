{
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
    ./theme.nix
  ];
  programs.yazi = {
    enable = true;
    initLua = ''
      require("full-border"):setup({
        type = ui.Border.ROUNDED,
      })
      require("git"):setup()
      require("no-status"):setup()
    '';
  };
}
