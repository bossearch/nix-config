{
  config,
  pkgs,
  lib,
  ...
}: let
  tealdeer_cache = "${config.home.homeDirectory}/.cache/tealdeer";
in {
  programs.tealdeer = {
    enable = true;
    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {
        auto_update = true;
      };
    };
  };

  home.activation.updatetldr = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${tealdeer_cache}" ];  then
      ${pkgs.tealdeer}/bin/tldr --update
    fi
  '';
}
