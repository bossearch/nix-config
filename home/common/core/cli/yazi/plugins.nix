{pkgs, ...}: {
  programs.yazi.plugins = {
    chmod = pkgs.yaziPlugins.chmod;
    full-border = pkgs.yaziPlugins.full-border;
    git = pkgs.yaziPlugins.git;
    mediainfo = pkgs.yaziPlugins.mediainfo;
    no-status = pkgs.yaziPlugins.no-status;
    ouch = pkgs.yaziPlugins.smart-enter;
    smart-enter = pkgs.yaziPlugins.smart-enter;
    smart-paste = pkgs.yaziPlugins.smart-paste;
  };
}
