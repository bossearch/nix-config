{pkgs, ...}: {
  programs.yazi.plugins = {
    chmod = pkgs.yaziPlugins.chmod;
    full-border = pkgs.yaziPlugins.full-border;
    mediainfo = pkgs.yaziPlugins.mediainfo;
    no-status = pkgs.yaziPlugins.no-status;
    ouch = pkgs.yaziPlugins.ouch;
    smart-enter = pkgs.yaziPlugins.smart-enter;
    smart-filter = pkgs.yaziPlugins.smart-filter;
    smart-paste = pkgs.yaziPlugins.smart-paste;
    toggle-pane = pkgs.yaziPlugins.toggle-pane;
    wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
  };
}
