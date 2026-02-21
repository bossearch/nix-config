{
  homes,
  hosts,
  lib,
  mylib,
  ...
}: {
  imports = mylib.autoimport ./.;

  home.file.".mozilla/firefox/${hosts.username}/chrome/userChrome.css" = lib.mkIf homes.firefox.enable {
    text = ''
      @import url(extras/custom-button.css);
      @import url(extras/custom-colors.css);
      @import url(extras/custom-compact.css);
      @import url(extras/custom-context.css);
      @import url(extras/custom-others.css);
      @import url(extras/custom-tabbar.css);
      @import url(extras/custom-urlbar.css);
    '';
  };
}
