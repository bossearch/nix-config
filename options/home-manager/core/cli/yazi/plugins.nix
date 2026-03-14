{pkgs, ...}: {
  programs.yazi.plugins = {
    chmod = pkgs.stable.yaziPlugins.chmod;
    full-border = pkgs.stable.yaziPlugins.full-border;
    git = pkgs.stable.yaziPlugins.git;
    no-status = pkgs.stable.yaziPlugins.no-status;
    ouch = pkgs.stable.yaziPlugins.ouch;
    smart-enter = pkgs.stable.yaziPlugins.smart-enter;
    smart-paste = pkgs.stable.yaziPlugins.smart-paste;
    mediainfo = pkgs.stable.yaziPlugins.mediainfo;
  };
}
