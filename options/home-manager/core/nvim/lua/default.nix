{
  config,
  homes,
  lib,
  mylib,
  ...
}: {
  home = lib.mkIf config.programs.neovim.enable {
    file.".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Devs/nvim-config";
  };

  imports = mylib.autoimport ./.;

  programs.neovim = {
    enable = homes.neovim == "lua";
    defaultEditor = true;
    sideloadInitLua = true;
    withNodeJs = false;
    withPerl = false;
    withPython3 = false;
    withRuby = false;
    vimdiffAlias = true;
  };
}
