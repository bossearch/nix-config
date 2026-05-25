{
  config,
  hosts,
  inputs,
  lib,
  mylib,
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
      defaultSopsFile = mylib.at "homes/${hosts.username}/secrets.yaml";
      secrets = {
        latitude = {};
        longitude = {};
        deepl = {};
        transmission = {};
        corne = {};
      };

      templates = {
        coordinate = {
          content = ''
            ${config.sops.placeholder.latitude},${config.sops.placeholder.longitude}
          '';
          path = "${cacheDir}/coordinate";
          mode = "0400";
        };
        deepl = {
          content = config.sops.placeholder.deepl;
          path = "${cacheDir}/deepl";
          mode = "0400";
        };
        transmission = {
          content = config.sops.placeholder.transmission;
          path = "${cacheDir}/transmission";
          mode = "0400";
        };
        corne = {
          content = config.sops.placeholder.corne;
          path = "${cacheDir}/corne";
          mode = "0400";
        };
      };
    };
  };
}
