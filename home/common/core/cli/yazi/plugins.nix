{pkgs, ...}: {
  programs.yazi.plugins = {
    chmod = pkgs.yaziPlugins.chmod;
    full-border = pkgs.yaziPlugins.full-border;
    git = pkgs.yaziPlugins.git;
    no-status = pkgs.yaziPlugins.no-status;
    ouch = pkgs.yaziPlugins.ouch;
    smart-enter = pkgs.yaziPlugins.smart-enter;
    smart-paste = pkgs.yaziPlugins.smart-paste;
    mediainfo = pkgs.yaziPlugins.mediainfo;
  };
}
