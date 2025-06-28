{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.buku];

  home.file.".local/share/buku" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-config/home/bosse/common/core/cli/buku/data";
    recursive = true;
  };
}
