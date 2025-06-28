{pkgs, ...}: {
  imports = [./extra];
  programs.firefox = {
    enable = true;
    profiles.bosse = {
      id = 0;
      isDefault = true;
      search = {
        default = "ddg";
        privateDefault = "ddg";
        engines = {
          "bing".metaData.hidden = true;
          "google".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };
        force = true;
      };
      extensions = {
        force = true;
        packages = with pkgs.inputs.firefox-addons; [
          cookie-autodelete
          darkreader
          new-tab-override
          onetab
          proton-pass
          side-view
          sponsorblock
          tweaks-for-youtube
          ublock-origin
          vimium
        ];
      };
    };
    nativeMessagingHosts = [pkgs.bukubrow];
  };
}
