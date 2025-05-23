{pkgs, ...}: {
  programs.newsboat = {
    enable = true;
    browser = "${pkgs.xdg-utils}/bin/xdg-open";
    urls = [
      {
        title = "r/linux";
        tags = ["Reddit" "Linux"];
        url = "https://reddit.com/r/linux.rss !";
      }
      {
        title = "r/unixporn";
        tags = ["Reddit" "Linux"];
        url = "https://reddit.com/r/unixporn.rss !";
      }
      {
        title = "r/neovim";
        tags = ["Reddit"];
        url = "https://reddit.com/r/neovim.rss !";
      }
      {
        title = "r/NixOS";
        tags = ["Reddit" "Linux"];
        url = "https://reddit.com/r/NixOS.rss !";
      }
      {
        title = "r/gaming";
        tags = ["Reddit" "Games"];
        url = "https://reddit.com/r/gaming.rss !";
      }
      {
        title = "r/DotA2";
        tags = ["Reddit" "Games"];
        url = "https://reddit.com/r/DotA2.rss !";
      }
      {
        title = "r/Minecraft";
        tags = ["Reddit" "Games"];
        url = "https://reddit.com/r/Minecraft.rss !";
      }
      {
        title = "r/MinecraftMemes";
        tags = ["Reddit" "Memes"];
        url = "https://reddit.com/r/MinecraftMemes.rss !";
      }
      {
        title = "r/indonesia";
        tags = ["Reddit" "Local"];
        url = "https://reddit.com/r/indonesia.rss !";
      }
      {
        title = "NixOS/nixpkgs";
        tags = ["GitHub"];
        url = "https://github.com/NixOS/nixpkgs/commits/master.atom !";
      }
      {
        title = "DistroTube";
        tags = ["YouTube"];
        url = "https://youtube.com/feeds/videos.xml?channel_id=UCVls1GmFKf6WlTraIb_IaJg !";
      }
      {
        title = "BrodieRobertson";
        tags = ["YouTube"];
        url = "https://youtube.com/feeds/videos.xml?channel_id=UCld68syR8Wi-GY_n4CaoJGA !";
      }
      {
        title = "LukeSmith";
        tags = ["YouTube"];
        url = "https://youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA !";
      }
      {
        title = "JagatReview";
        tags = ["YouTube"];
        url = "https://youtube.com/feeds/videos.xml?channel_id=UCbyVnlQdFIcdViuoPIPK68A !";
      }
      {
        title = "DistroWatch";
        tags = ["Linux" "News"];
        url = "https://distrowatch.com/news/dw.xml !";
      }

    ];
    queries = {
      Reddit = "tags =~ \"Reddit\"";
      YouTube = "tags =~ \"YouTube\"";
      GitHub = "tags =~ \"GitHub\"";
      Linux = "tags =~ \"Linux\"";
      Games = "tags =~ \"Games\"";
      Memes = "tags =~ \"Memes\"";
      Local = "tags =~ \"Local\"";
      News = "tags =~ \"News\"";
    };
    extraConfig = ''
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

      bind-key ESC quit
      bind-key h quit
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key H prev-feed
      bind-key L next-feed
      bind-key o open-in-browser-and-mark-read
      bind-key ; macro-prefix

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
    '';
  };
  xdg.desktopEntries.newsboat = {
    type = "Application";
    name = "newsboat";
    exec = "kitty -T newsboat newsboat";
    comment = "Open newsboat with kitty";
  };
}
