{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.buku];

  home.file.".local/share/buku" = {
    source = config.lib.file.mkOutOfStoreSymlink ./data;
    recursive = true;
  };
}
