{
  config,
  homes,
  hosts,
  inputs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = homes.firefox.enable;
    configPath = ".mozilla/firefox";
    policies = import ./policies {inherit hosts;};
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
        userContent = ''
          @-moz-document url-prefix("about:") {
            html,
            body {
              background-color: #${config.colorScheme.palette.base01} !important;
              color: #${config.colorScheme.palette.base07} !important;
            }
          }
          @-moz-document domain("vimium.github.io") {
            html,
            body {
              background-color: #${config.colorScheme.palette.base01} !important;
            }
          }
        '';
        extraConfig = import ./extras {
          inherit homes hosts inputs;
        };
      };
    };
  };
}
