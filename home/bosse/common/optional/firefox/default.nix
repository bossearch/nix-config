{pkgs, ...}: {
  imports = [./extra];
  programs.firefox = {
    enable = true;
    profiles.bosse = {
      id = 0;
      isDefault = true;
      search = {
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        engines = {
          "Bing".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };
        force = true;
      };
      extensions = with pkgs.inputs.firefox-addons; [
        cookie-autodelete
        darkreader
        new-tab-override
        onetab
        proton-pass
        side-view
        sponsorblock
        tweaks-for-youtube
        # ublock-origin
        vimium
      ];
    };
    nativeMessagingHosts = [pkgs.bukubrow];
  };
}
