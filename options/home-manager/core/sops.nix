{
  config,
  hosts,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cacheDir = "${config.home.homeDirectory}/.cache/${hosts.username}";
in {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  config = lib.mkIf hosts.sops {
    home.packages = with pkgs; [
      sops
    ];

    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      defaultSopsFile = ../../../homes/${hosts.username}/secrets.yaml;
      secrets = {
        "Latitude" = {};
        "Longitude" = {};
        "deepl" = {};
        "transmission" = {};
      };

      templates = {
        "coordinate" = {
          content = ''
            Latitude: ${config.sops.placeholder."Latitude"}
            Longitude: ${config.sops.placeholder."Longitude"}
          '';
          path = "${cacheDir}/coordinate";
          mode = "0400";
        };
        "deepl" = {
          content = config.sops.placeholder."deepl";
          path = "${cacheDir}/deepl";
          mode = "0400";
        };
        "transmission" = {
          content = config.sops.placeholder."transmission";
          path = "${cacheDir}/transmission";
          mode = "0400";
        };
      };
    };
  };
}
