{
  config,
  homes,
  hosts,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [./extras/activation.nix];

  home.packages = lib.mkIf homes.firefox.enable (with pkgs; [
    xdm
  ]);

  programs.firefox = {
    enable = homes.firefox.enable;
    policies = import ./policies {inherit homes;};
    profiles = {
      ${hosts.username} = {
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
        userChrome = lib.concatStringsSep "\n" (
          map
          (file: import file {inherit config homes;})
          [
            ./extras/userChrome/custom-button.nix
            ./extras/userChrome/custom-colors.nix
            ./extras/userChrome/custom-compact.nix
            ./extras/userChrome/custom-context.nix
            ./extras/userChrome/custom-others.nix
            ./extras/userChrome/custom-tabbar.nix
            ./extras/userChrome/custom-urlbar.nix
          ]
        );
        extraConfig = import ./extras {
          inherit homes hosts inputs;
        };
      };
    };
  };
}
