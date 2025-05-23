{...}: {
  imports = [./includes];
  home.file.".mozilla/firefox/bosse/chrome/userChrome.css" = {
    text = ''
      @import url(includes/custom-button.css);
      @import url(includes/custom-colors.css);
      @import url(includes/custom-compact.css);
      @import url(includes/custom-others.css);
      @import url(includes/custom-tabbar.css);
      @import url(includes/custom-urlbar.css);
    '';
  };
}
