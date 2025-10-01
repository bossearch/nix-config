{config, ...}: {
  imports = [./extras];
  home.file.".mozilla/firefox/${config.spec.userName}/chrome/userChrome.css" = {
    text = ''
      @import url(extras/custom-button.css);
      @import url(extras/custom-colors.css);
      @import url(extras/custom-compact.css);
      @import url(extras/custom-others.css);
      @import url(extras/custom-tabbar.css);
      @import url(extras/custom-urlbar.css);
    '';
  };
}
