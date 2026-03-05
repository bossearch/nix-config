{pkgs, ...}: ''
  macro f set browser "${pkgs.firefox}/bin/firefox %u"
  macro p set browser "${pkgs.firefox}/bin/firefox --private-window %u"
  macro m set browser "${pkgs.mpv}/bin/mpv --player-operation-mode=pseudo-gui --input-ipc-server=/tmp/mpv-socket %u"
  show-title-bar no
  refresh-on-startup yes
  prepopulate-query-feeds yes

  ignore-mode "display"
  ignore-article "*" "age > 7"
  ignore-article "https://reddit.com/r/unixporn.rss" \
    "title !# \"[OC]\" and \
    title !# \"[Hyprland]\" and \
    title !# \"[Awesome]\""

  unbind-key ENTER
  bind-key ESC quit
  bind-key h quit
  bind-key j down
  bind-key k up
  bind-key l open
  bind-key H prev-feed
  bind-key L next-feed
  bind-key o open-in-browser-and-mark-read
  bind-key O open-in-browser
  bind-key ENTER macro-prefix

  color listnormal         color15 default
  color listnormal_unread  color2  default
  color listfocus_unread   color2  color0
  color listfocus          default color0
  color background         default default
  color article            default default
  color end-of-text-marker color8  default
  color info               color4  color8
  color hint-separator     default color8
  color hint-description   default color8
  color title              color14 color8

  # highlights
  highlight all "---.*---" yellow
  highlight feedlist ".*(0/0))" black
  highlight article "(^Feed:|^Title:|^Date:|^Link:|^Author:)" cyan default bold
  highlight article "https?://[^ ]+" yellow default
  highlight article "\\[[0-9][0-9]*\\]" magenta default bold
  highlight article "\\[image\\ [0-9]+\\]" green default bold
  highlight article "\\[embedded flash: [0-9][0-9]*\\]" green default bold
  highlight article ":.*\\(link\\)$" cyan default
  highlight article ":.*\\(image\\)$" blue default
  highlight article ":.*\\(embedded flash\\)$" magenta default
''
