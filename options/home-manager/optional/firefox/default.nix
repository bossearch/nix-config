{
  homes,
  hosts,
  lib,
  pkgs,
  ...
}: {
  imports = [./my-custom-fox];
  home.packages = lib.mkIf homes.firefox.enable (with pkgs; [
    xdm
  ]);

  programs.firefox = {
    enable = homes.firefox.enable;
    # policies = import ./policies;
    policies = import ./policies {inherit homes;};
    profiles.${hosts.username} = {
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
