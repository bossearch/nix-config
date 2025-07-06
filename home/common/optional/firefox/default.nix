{
  imports = [./extra];
  programs.firefox = {
    enable = true;
    policies = import ./policies;
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
    };
  };
}
